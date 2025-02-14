import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'imag_bloc.dart';
import 'image_model.dart';

class ImagePecker extends StatefulWidget {
  ImagePecker(
      {Key? key,
        required this.onImage,
        required this.place,
        this.networkImage = "",
        this.fileNom = 0,
        this.iconSize = 30,
        this.hight = 100,
        this.width = 100,
        this.iconColor = Colors.white,
        this.shape = BoxShape.circle})
      : super(key: key);
  ImagePickerModele? addimagep;
  Function(FileModel file) onImage;
  String place;
  String networkImage = "";
  int fileNom = 0;
  double hight;
  double width;
  double iconSize = 30;
  BoxShape shape = BoxShape.circle;
  Color iconColor = Colors.white;
  @override
  _ImagePeckerState createState() => _ImagePeckerState();
}

class _ImagePeckerState extends State<ImagePecker> {
  bool imgshwo = false;
  bool imgget = false;
  late ImagePickerModele addimagep;

  @override
  void initState() {
    if (widget.addimagep == null) {
      addimagep = ImagePickerModele();
    } else {
      addimagep = widget.addimagep!;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.networkImage != null || widget.networkImage != "") {
      addimagep.setwebimage(widget.networkImage);
    }
    imgget = addimagep.imgget;

    return BlocConsumer(
        bloc: addimagep,
        listenWhen: (c, p) => c != p,
        listener: (context, state) {
          if (state is FileLoaded) {
            ImageFileLoading.imagFile = addimagep.fileImage;
            if (kIsWeb) {
              addimagep.networkImage = addimagep.fileImagePath;
            }
            widget.onImage(FileModel(
              multiFile: addimagep.multiFile,
              fileImage: addimagep.fileImage,
              fileImagePath: addimagep.fileImagePath,
              xFile: addimagep.xFile,

              fileImageFrombytes: addimagep.fileImageFrombytes,
              networkImage: addimagep.networkImage,
            ));
          }
        },
        builder: (context, state) {
          ImageFileLoading.imagFile = addimagep.fileImage;

          return Container(
            width: widget.width,
            height: widget.hight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        imgshwo = !imgshwo;
                      });
                    },
                    child: Stack(
                      children: [
                        Center(
                          child: Container(
                              width: widget.width,
                              height: widget.hight,
                              decoration: BoxDecoration(
                                shape: widget.shape,
                                border:
                                Border.all(color: Colors.white, width: 2),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: addimagep.networkImage != ""
                                  ? Image(
                                image:
                                NetworkImage(addimagep.networkImage),
                              )
                                  : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: addimagep.imgget
                                      ? Image(
                                    image: FileImage(
                                        addimagep.fileImage!),
                                  )
                                      : Image(
                                    image: AssetImage(widget.place),
                                  ),
                                ),
                              )),
                        ),
                        Positioned.fill(
                          right: -widget.width / 2 + 60,
                          bottom: -widget.hight / 2 + 10,
                          child: Icon(
                            Icons.add_a_photo,
                            size: widget.iconSize,
                            color: widget.iconColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                    child: imgshwo
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        kIsWeb
                            ? Container()
                            : Expanded(
                            child: MaterialButton(
                              onPressed: () {
                                addimagep.setgetimage(false);
                                addimagep.getImage(ImageSource.camera);
                                imgshwo = false;
                              },
                              child: Icon(
                                Icons.add_a_photo,
                                size: widget.iconSize,
                                color: widget.iconColor,
                              ),
                            )),
                        Expanded(
                            child: MaterialButton(
                              onPressed: () {
                                addimagep.setgetimage(false);
                                addimagep.getImage(ImageSource.gallery);
                                imgshwo = false;
                              },

                              child: Container(
                                color: Colors.black.withOpacity(0.3),
                                child: Icon(
                                  Icons.add_photo_alternate_sharp,
                                  size: widget.iconSize,
                                  color: widget.iconColor,
                                ),
                              ),
                            ))
                      ],
                    ).animate().scaleY(
                      begin: 0,
                      end: 1,
                      duration: Duration(milliseconds: 100),
                    )
                        : Container()),
              ],
            ),
          );
        });
  }
}
