import 'package:JoDija_view/util/view_data_model/base_data_model.dart';
import 'package:mashir_service/data/model/images.dart';

class Images  extends ImagesDataModel   implements BaseViewDataModel {
  static String  imageKey = "image";
  Images({required super.image , required super.id });
  Images fromJson(Map<String, dynamic> json ,String id ) {
    return Images(image: json['image']
    ,id: id
    );
  }

}