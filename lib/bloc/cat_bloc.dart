

import 'package:JoDija_DataSource/reposetory/repsatory_http.dart';
import 'package:JoDija_DataSource/source/firebase/crud_firebase_source.dart';
import 'package:JoDija_DataSource/utilis/models/base_data_model.dart';
import 'package:JoDija_DataSource/utilis/models/remote_base_model.dart';
import 'package:JoDija_view/util/data_souce_bloc/base_bloc.dart';
import 'package:JoDija_view/util/data_souce_bloc/base_state.dart';
import 'package:JoDija_view/util/data_souce_bloc/feature_data_source_state.dart';
import 'package:JoDija_view/util/data_souce_bloc/remote_base_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mashir_service/data/logic_injicts.dart';
import 'package:mashir_service/data/model/category.dart';
import 'package:mashir_service/data/repo/category_repo.dart';

import '../data/category.dart';



class CategoryBloc  extends Cubit<FeaturDataSourceState<CategoryViewDataModel> > {

 CategoryBloc(): super(FeaturDataSourceState<CategoryViewDataModel>.defaultState()){

 }


  String nameKey = 'name';
  String ImageUrlKey = 'image';
  String descriptionKey = 'description';
  String createdAtKey = 'createdAt';
  String updatedAt = 'updatedAt';

  // add the bloc logic here
void AddCategory (Map<String, dynamic > data , Object?  fie  ) {
  CategoryRepo repo = CategoryInjects.addCategory(dataModel: data, file: fie);
  
  emit(state.copyWith(feadState: DataSourceBaseState.loading()));
  repo.addData().then((value) {

    emit(state.copyWith(feadState: DataSourceBaseState.success( "done ")));
  }).catchError((e) {
    emit(state.copyWith(feadState: DataSourceBaseState.failure(
        ErrorStateModel(message: e.toString()), () {})));
  });
}

 void editCategory (Map<String, dynamic > data , Object?  fie  , String id  ) {
   CategoryRepo repo = CategoryInjects.editCategory(dataModel: data, file: fie);

   emit(state.copyWith(feadState: DataSourceBaseState.loading()));
   repo.updateData(id).then((value) {



     emit(state.copyWith(feadState: DataSourceBaseState.success( "done ")));
   }).catchError((e) {
     emit(state.copyWith(feadState: DataSourceBaseState.failure(
         ErrorStateModel(message: e.toString()), () {})));
   });
 }

 void  deleteCategory ( String imags ,  String id  ) {
   CategoryRepo repo = CategoryInjects.deleteCategory( imags );

   emit(state.copyWith(feadState: DataSourceBaseState.loading()));
   repo.deleteData(id).then((value) {
     emit(state.copyWith(feadState: DataSourceBaseState.success( "done ")));
   }).catchError((e) {
     emit(state.copyWith(feadState: DataSourceBaseState.failure(
         ErrorStateModel(message: e.toString()), () {})));
   });
 }

  void getCategories() {
    CategoryRepo repo = CategoryInjects.getCategoryRepo();
    emit(state.copyWith(feadState: DataSourceBaseState.init()));
    emit(state.copyWith(listState: DataSourceBaseState.loading()));
    repo.getListData().then((value) {
      List<CategoryViewDataModel>list = [];


      value.data!.forEach((element) {

        list.add(CategoryViewDataModel(name: element.name, image: element.image
        ,id: element.id, nameEn: element.nameEn,
        ) );
      });

      emit(state.copyWith(listState: DataSourceBaseState.success(list )));
    }).catchError((e) {
      emit(state.copyWith(listState: DataSourceBaseState.failure(ErrorStateModel(message: e.toString()), (){})));
    });
  }


}




