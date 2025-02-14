import 'package:JoDija_view/util/view_data_model/base_data_model.dart';
import 'package:mashir_service/data/model/category.dart';

class CategoryViewDataModel extends CategoryDataModel implements BaseViewDataModel {
  CategoryViewDataModel({required super.name, required super.image , required super.nameEn
    ,super.id}){
    this.map = this.toJson() ;
  }

}