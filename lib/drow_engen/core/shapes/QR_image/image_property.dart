import 'dart:ui';

import 'package:JoDija_view/util/app_settings/settings_inherted.dart';
import 'package:JoDija_view/util/data_souce_bloc/feature_data_source_state.dart';
import 'package:JoDija_view/util/functions/show_dialog.dart';
import 'package:JoDija_view/util/main-screen/screen-type.dart';
import 'package:JoDija_view/util/widgits/collections_widgets/grid_view_model.dart';
import 'package:Mashair/drow_engen/core/shapes/QR_image/text_editor.dart';
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
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../loclization/app_localizations.dart';
import '../../../bloc/images_bloc.dart';
import '../../../data/images.dart';
import '../../bloc/main_bloc/main_bloc.dart';
import '../../interfaces/base_shap.dart';

import '../text/text_editor.dart';
import '../text/text_property.dart';
import 'image_shap.dart';

class QRImageProperty extends StatefulWidget implements Widget {
  QRImageProperty(
      {super.key, required this.shape, this.localPath = "assets/card.png"});
  BaseShape shape;
  String localPath = '';
  @override
  State<QRImageProperty> createState() => _QRImagePropertyState();
}

class _QRImagePropertyState extends State<QRImageProperty> {
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
  QRImageShape? newImage;
  String text = '';
  bool istransfer = false;
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
    newImage = widget.shape as QRImageShape;

    x = newImage!.xPos;
    y = newImage!.yPos;
    width = newImage!.width;
    height = newImage!.height;
    // drowImage = newImage!.drowImage;
    return BlocListener<DrawEngineMainBloc, MainState>(
      listener: (context, state) {
        if (state is ShapeSelected) {
          BaseShape Shape = state.shape;
          if (Shape is QRImageShape) {
            newImage = state.shape as QRImageShape;
            x = newImage!.xPos;
            y = newImage!.yPos;

            width = newImage!.width;
            height = newImage!.height;
            istransfer = newImage!.isTransfrared;
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
              child: WidgetTextEdit(),
            ),
          )
        ],
      )),
    );
  }

  Widget WidgetTextEdit() {
    return Container(

      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            ElevatedButton(
              onPressed: () {
                bool iskeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
                ScreenType screenType;
                screenType = ScreenType.web;
                ShowInputFieldsDialogs<Texting> sd =
                    ShowInputFieldsDialogs<Texting>(
                        height: iskeyboard ? 700 : 200,
                        content: QRTextEditor(
                          text: text,
                        ),
                        screenType: screenType);
                sd.showDialogs(context, onResult: (data) async {
                  await toQrImageData(data!.id!).then((image) {
                    text = data!.id!;
                    setState(() {});
                    bloc!.add(OnLayerItemPropertyChange(
                        shape: QRImageShape(
                            xPos: x,
                            yPos: y,
                            qrImage: image,
                            text: text,
                            width: width,
                            height: height,
                            isTransfrared: istransfer)!));
                  });
                });
              },
              child: Text(  Translation().translate().DrowEngetTextPastLinkEdit,),
            ),
          ],
        ),
      ),
    );
  }

  Future<ui.Image> toQrImageData(String text) async {
    try {
      return await QrPainter(
        data: text,
        version: QrVersions.auto,
        gapless: false,
        color: Colors.black,
      ).toImage(300);
    } catch (e) {
      throw e;
    }
  }
}
