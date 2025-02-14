import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// screen util
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  bool imgshwo = true ;
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

    return Container(
      child: BlocConsumer(
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

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  kIsWeb
                      ? Container()
                      : GestureDetector(
                      onTap: () {
                        addimagep.setgetimage(false);
                        addimagep.getImage(ImageSource.camera);

                      } ,
                        child: Container(
                          width: 200.w,
                          height: 50.h ,
                          child: Row(
                            children: [
                              Icon(
                                Icons.add_a_photo,
                                size: widget.iconSize,
                                color: widget.iconColor,
                              ),
                           SizedBox(width: 10,),
                           Text("كاميرا" ,style: TextStyle(color: Colors.black),),

                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          addimagep.setgetimage(false);
                          addimagep.getImage(ImageSource.gallery);

                        },


                        child: Container(

                        width: 200.w ,
                        height: 50.h ,
                        child: Row(
                          children: [
                            Icon(
                              Icons.add_photo_alternate_sharp,
                              size: widget.iconSize,
                              color: widget.iconColor,
                            ),
                            SizedBox(width: 10,),
                            Text("معرض الصور" ,style: TextStyle(color: Colors.black),),
                          ],
                        )),
                      )
                ],
              )


            );
          }),
    );
  }

Widget getImage (){
    return Container(
      width: widget.width,
      height: widget.hight,
      decoration: BoxDecoration(
        shape: widget.shape,
        // border:
        // Border.all(color: Colors.white, width: 2),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.5),
        //     spreadRadius: 1,
        //     blurRadius: 7,
        //     offset: Offset(
        //         0, 3), // changes position of shadow
        //   ),
        // ],
      ),
      child: addimagep.networkImage != ""
          ? Image(
        image:
        NetworkImage(addimagep.networkImage),
      )
          : Container(
            child: addimagep.imgget
                ? Image(
              image: FileImage(
                  addimagep.fileImage!),
            )
                : Image(
              image: AssetImage(widget.place ,),
            height: 100,width: 100 ,),
          )) ;
}

}
