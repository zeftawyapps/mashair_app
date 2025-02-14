import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:Mashair/consts/views/assets.dart';
import 'package:Mashair/drow_engen/core/shapes/QR_image/image_shap.dart';
import 'package:mashir_service/consts/views/assets.dart';

import 'core/contrallers/drow_tools_contraller.dart';
import 'core/interfaces/base_shap.dart';
import 'core/models/drow_tools.dart';
import 'core/shapes/avatarwork_image/image_shap.dart';
import 'core/shapes/image/image_property.dart';
import 'core/shapes/image/image_shap.dart';
import 'core/shapes/network_image/image_shap.dart';
import 'core/shapes/rectangel/rectangel_shap.dart';
import 'core/shapes/rectangel/rectangle_property.dart';
import 'core/shapes/text/text_property.dart';
import 'core/shapes/text/text_shap.dart';

class init {
  DrawToolsController toolsController = DrawToolsController();

  String? loadPath = "assets/card.png";

  init({loadPath = "assets/card.png"}) {
    main(loadPath: loadPath);
  }

  void main({String loadPath = "assets/logo.png"}) async {
    var textShape = TextShape(text: "نص");
    DrawTools text = DrawTools(textShape,
        propertyBoox: textShape.propertyBoox,
        iconSvg: MyAsset.TextToolIcon,
        icon: Icons.text_fields, onShapeClick: () {
      return TextShape(text: "اكتب النص هنا");
    });
    toolsController.addTool(text);
    // add rectangl tool and image

    BaseShape imageShape3 =
        await NetWorkImageShape.ImageFromAsset(path: loadPath!);
    BaseShape imageShape4 =
        await NetWorkImageShape.ImageFromAsset(path: loadPath!);

    DrawTools Netorkimage = DrawTools(imageShape3,
        propertyBoox: imageShape3.propertyBoox,
        iconSvg: MyAsset.stickerToolIcon,
        icon: Icons.sticky_note_2, onShapeClick: () {
      return imageShape4;
    });
    toolsController.addTool(Netorkimage);

    BaseShape imageShape5 =
        await AvatarImageShape.ImageFromAsset(path: loadPath!);
    BaseShape imageShape6 =
        await AvatarImageShape.ImageFromAsset(path: loadPath!);

    DrawTools Avatarimage = DrawTools(imageShape5,
        propertyBoox: imageShape6.propertyBoox,
        iconSvg: MyAsset.avatarToolIcon,
        icon: Icons.add, onShapeClick: () {
      return imageShape6;
    });
    // toolsController.addTool(Avatarimage);

    BaseShape QrCodeShape = await QRImageShape(
        xPos: 0,
        yPos: 0,
        width: 100,
        height: 100,
        qrImage: null,
        text: " QR  code for scane the text ");

    DrawTools QRImageDraw = DrawTools(QrCodeShape,
        propertyBoox: QrCodeShape.propertyBoox,
        iconSvg: MyAsset.avatarToolIcon,
        icon: Icons.add, onShapeClick: () {
      return QrCodeShape;
    });
    // toolsController.addTool(QRImageDraw);
  }
}
