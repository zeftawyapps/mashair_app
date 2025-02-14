
import 'dart:ui';

import 'package:JoDija_view/util/app_settings/settings_inherted.dart';
import 'package:JoDija_view/util/functions/show_dialog.dart';
import 'package:JoDija_view/util/main-screen/screen-type.dart';
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
 import '../../bloc/main_bloc/main_bloc.dart';
import '../../interfaces/base_shap.dart';
import '../size_point.dart';
import 'image_picker/add_image.dart';
import 'image_shap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageProperty extends StatefulWidget implements Widget {
  ImageProperty(
      {super.key, required this.shape, this.localPath = "assets/card.png"});
  BaseShape shape;
  String localPath = '';
  @override
  State<ImageProperty> createState() => _ImagePropertyState();
}

class _ImagePropertyState extends State<ImageProperty> {
  DrawEngineMainBloc? bloc;

  double x = 0;
  double y = 0;
  double width = 0;
  double height = 0;
  double layoutWidth = 0;
  double layoutHeight = 0;
  ui.Image? drowImage;
  Uint8List? unit8List ;
  ImageShape? newImage;
  @override
  Widget build(BuildContext context) {
    bloc = context.read<DrawEngineMainBloc>();
    layoutHeight = bloc!.engen.layout.height;
    layoutWidth = bloc!.engen.layout.width;
    newImage = widget.shape as ImageShape;
    x = newImage!.xPos;
    y = newImage!.yPos;
    width = newImage!.width;
    height = newImage!.height;
    drowImage = newImage!.drowImage;
    return BlocListener<DrawEngineMainBloc, MainState>(
      listener: (context, state) {
        if (state is ShapeSelected) {
         BaseShape shape  = state.shape  ;
          if (shape is ImageShape) {
            newImage = state.shape as ImageShape;
            x = newImage!.xPos;
            y = newImage!.yPos;
            drowImage = newImage!.drowImage;
            width = newImage!.width;
            height = newImage!.height;
          }
        }
      },
      child: Container(
          child: Column(
        children: [
          Center(child: Text('Property')),
          getImage(),



        ],
      )),
    );
  }

  Future<ui.Image> loadImageFromNetwork(String url) async {
    final image = NetworkImage(url);
    // get uinit8List from network
    http.Response response = await http.get(Uri.parse(url));
    unit8List = response.bodyBytes ;

    final Completer<ui.Image> completer = Completer();
    image.resolve(ImageConfiguration()).addListener(
          ImageStreamListener(
            (ImageInfo info, bool _) => completer.complete(info.image),
          ),
        );
    return completer.future;
  }

  Future<ui.Image> loadImage(Uint8List img ) async {
unit8List = img ;
    Codec  codec = await instantiateImageCodec(img) ;
    FrameInfo frameInfo = await codec.getNextFrame();
    return frameInfo.image;
  }

  Future<ui.Image> loadImageFromAsset(String path ) async {
    ByteData data = await rootBundle.load(path);
    unit8List = data.buffer.asUint8List() ;
    Codec  codec = await instantiateImageCodec(unit8List!) ;
    FrameInfo frameInfo = await codec.getNextFrame();
    return frameInfo.image;
  }

Widget imagePicker() {
  return ImagePecker(
      onImage: (v) async {
        Uint8List data;
        if (kIsWeb) {
          data = v.ImageUnit8!;
        } else {
          var file = v.fileImage;
          data = await file!.readAsBytes();
        }

        loadImage(data).then((value) {
          drowImage = value;
          int w = drowImage!.width;
          int h = drowImage!.height;
          if (w > layoutWidth) {
            w = layoutWidth.toInt() - 20;
          }
          // hight

          if (h > layoutHeight) {
            h = layoutHeight.toInt() - 20;
          }
          height = h.toDouble();
          width = w.toDouble();

          newImage = newImage!.copyWith(
              xPos: x,
              yPos: y,
              height: height,
              width: width,
              image: drowImage);

          bloc!.add(OnLayerItemPropertyChange(shape: newImage!));
        });
      },
      place: widget.localPath ,
    shape: BoxShape.rectangle,
    hight: 100.h ,
    width: 100.w ,
   iconColor: Colors.black,);



}
Widget assetImage(){
    return GestureDetector(
    onTap: () async{
      drowImage = await loadImageFromAsset(widget.localPath) ;

      newImage = newImage!.copyWith(
          xPos: x,
          yPos: y,
          height: height,
          width: width,
          image: drowImage
          ,imageData: unit8List!
      );
      bloc!.add(OnLayerItemPropertyChange(shape: newImage!));
    },
    child: Image(
      image: AssetImage(widget.localPath),
      width: 100.w ,
      height: 100.h ,
    ),
  );
}
Widget getImage(){
    return Row (
      children : [
        assetImage(),
        imagePicker(),
      ]
    );
}

}
