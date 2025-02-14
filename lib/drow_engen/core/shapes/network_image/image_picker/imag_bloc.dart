
import 'dart:io';
import 'dart:typed_data';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
class ImageState {}

class FileLoaded extends ImageState {}

class NoFileLoaded extends ImageState {}

class FileChooseing extends ImageState {}

class ImagePickerModele extends Cubit<ImageState> {
  bool imgshwo = false;
  bool imgget = false;
  String networkImage = "";
  File? fileImage;

  File? fileImageFrombytes ;
  Uint8List ? Imagebytes ;
  String fileImagePath  = '';
  XFile? xFile ;
  final picker = ImagePicker();
  MultipartFile? multiFile;
  ImagePickerModele() : super(ImageState());

  // late final pickedFile;
  Future getImage(ImageSource imgs) async {
    emit(FileChooseing());

    // pickedFile =
    await picker.pickImage(source: imgs).then((value)async {
      if (value != null) {
        String p = value.path;
        Uint8List bytes =await   value.readAsBytes();
        Imagebytes = bytes ;
        fileImagePath = p ;
        xFile =  value ;
        fileImage = File(p);
        fileImageFrombytes = File.fromRawPath(bytes);
        var imagefile = value;

        Uint8List image = Imagebytes!;
        String name = imagefile!.name;
        String extention =
        name.substring(name.lastIndexOf(".") + 1);
        // rename file use date time micorsecond
        name =
            DateTime.now().microsecondsSinceEpoch.toString() +
                "." +
                extention;
        multiFile = MultipartFile.fromBytes(
         name ,
          image,
          filename: name,
          contentType: MediaType.parse(
              imagefile.mimeType ?? "image/png"),
        );
        // ignore: unnecessary_null_comparison
        if (fileImage == null) {
          imgget = false;
          emit(NoFileLoaded());
        } else {
          imgget = true;
          networkImage = '';

          emit(FileLoaded());
        }
      } else {
        fileImage = null;
        print('No image selected.');
      }
    });

    imgshwo = false;
  }

  void setgetimage(bool getimag) {
    imgget = getimag;
  }

  void setwebimage(String? url) {
    networkImage = url??"";
  }
}

class ImageFileLoading {
  static   File? imagFile;
  static  List<File> imagFiles = [];
}
