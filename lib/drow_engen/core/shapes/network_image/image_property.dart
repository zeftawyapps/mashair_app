import 'dart:ui';

import 'package:JoDija_view/util/app_settings/settings_inherted.dart';
import 'package:JoDija_view/util/data_souce_bloc/feature_data_source_state.dart';
import 'package:JoDija_view/util/functions/show_dialog.dart';
import 'package:JoDija_view/util/main-screen/screen-type.dart';
import 'package:JoDija_view/util/widgits/collections_widgets/grid_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../bloc/images_bloc.dart';
import '../../../data/images.dart';
import '../../bloc/main_bloc/main_bloc.dart';
import '../../interfaces/base_shap.dart';
import '../size_point.dart';
import 'image_picker/add_image.dart';
import 'image_shap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'wedgets/images_netowrk.dart';

class NetWorkImageProperty extends StatefulWidget implements Widget {
  NetWorkImageProperty(
      {super.key, required this.shape, this.localPath = "assets/card.png"});
  BaseShape shape;
  String localPath = '';
  @override
  State<NetWorkImageProperty> createState() => _NetWorkImagePropertyState();
}

class _NetWorkImagePropertyState extends State<NetWorkImageProperty> {
  DrawEngineMainBloc? bloc;
  late ImagesBloc Imagbloc;
  double x = 0;
  double y = 0;
  double width = 0;
  double height = 0;
  double layoutWidth = 0;
  double layoutHeight = 0;
  ui.Image? drowImage;
  Uint8List? unit8List;
  NetWorkImageShape? newImage;
  String url = '';

  @override
  void initState() {
    // TODO: implement initState
    bloc = context.read<DrawEngineMainBloc>();

    Imagbloc = context.read<ImagesBloc>();
    Imagbloc.getImagesSticker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    newImage = widget.shape as NetWorkImageShape;
    drowImage = newImage!.drowImage;
    unit8List = newImage!.imageUint8;
    x = newImage!.xPos;
    y = newImage!.yPos;
    width = newImage!.width;
    height = newImage!.height;
    // drowImage = newImage!.drowImage;
    return BlocListener<DrawEngineMainBloc, MainState>(
      listener: (context, state) {
        if (state is ShapeSelected) {
          BaseShape Shape = state.shape;
          if (Shape is NetWorkImageShape) {
            newImage = state.shape as NetWorkImageShape;

            x = newImage!.xPos;
            y = newImage!.yPos;
            drowImage = newImage!.drowImage;
            unit8List = newImage!.imageUint8;
            width = newImage!.width;
            height = newImage!.height;
          }
        }
      },
      child: Container(
          child: Wrap(
        children: [
          SizedBox(
            height: 50,
          ),
          Container(
            child: Container(
              child: BlocBuilder<ImagesBloc, FeaturDataSourceState<Images>>(
                builder: (context, state) {
                  return state.listState.maybeWhen(orElse: () {
                    return Container();
                  }, loading: () {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }, success: (data) {
                    return Container(
                      height: 300,
                      child: GridViewModel<Images>(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        data: data!,
                        listItem: (index, data) {
                          return GestureDetector(
                            onTap: () {
                              showImages(data.image);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                  image: NetworkImage(
                                    data.image!,
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }, failure: (value, void Function() voidFunction) {
                    return Container();
                  });
                },
              ),
            ),
          )
        ],
      )),
    );
  }

  void showImages(String url) async {
    ui.Image img = await loadImageFromNetwork(url);
    double w = img.width.toDouble() > 200 ? 200 - 20 : img.width.toDouble();
    double h = img.height.toDouble() > 200 ? 200 - 20 : img.height.toDouble();
    newImage = newImage!.copyWith(
        xPos: x,
        yPos: y,
        width: w,
        height: h,
        image: img,
        url: url,
        imageData: unit8List);
    bloc!.add(OnLayerItemPropertyChange(shape: newImage!));
  }

  Future<ui.Image> loadImageFromNetwork(String url) async {
    final image = NetworkImage(url);
    // get uinit8List from network
    http.Response response = await http.get(Uri.parse(url));
    unit8List = response.bodyBytes;

    final Completer<ui.Image> completer = Completer();
    image.resolve(ImageConfiguration()).addListener(
          ImageStreamListener(
            (ImageInfo info, bool _) => completer.complete(info.image),
          ),
        );
    return completer.future;
  }

  Future<ui.Image> loadImage(Uint8List img) async {
    unit8List = img;
    Codec codec = await instantiateImageCodec(img);
    FrameInfo frameInfo = await codec.getNextFrame();
    return frameInfo.image;
  }

  Future<ui.Image> loadImageFromAsset(String path) async {
    ByteData data = await rootBundle.load(path);
    unit8List = data.buffer.asUint8List();
    Codec codec = await instantiateImageCodec(unit8List!);
    FrameInfo frameInfo = await codec.getNextFrame();
    return frameInfo.image;
  }
}
