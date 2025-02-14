import 'package:JoDija_view/util/view_data_model/base_data_model.dart';
import 'package:mashir_service/data/model/suggesment_model.dart';

class SuggesmtnDataModel extends SuggetModel implements BaseViewDataModel{
  SuggesmtnDataModel({required super.email, required super.phone, required super.massage});
@override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    return super.toJson();
  }
}