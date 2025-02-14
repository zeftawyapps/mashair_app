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
import 'package:mashir_service/data/repo/category_repo.dart';
import 'package:mashir_service/data/repo/products_repo.dart';

import '../data/product.dart';

class ProductBloc extends Cubit<FeaturDataSourceState<ProductViewDataModel>> {
  ProductBloc()
      : super(FeaturDataSourceState<ProductViewDataModel>.defaultState()) {}

  // add the bloc logic here
  void addProduct(Map<String, dynamic> data, String catId, Object? file) {
    ProductsRepo repo = ProductInjects.addProduct(
        dataModel: data, categoryId: catId, file: file);

    emit(state.copyWith(feadState: DataSourceBaseState.loading()));
    repo.addData().then((value) {
      emit(state.copyWith(feadState: DataSourceBaseState.success("done ")));
    }).catchError((e) {
      emit(state.copyWith(
          feadState: DataSourceBaseState.failure(
              ErrorStateModel(message: e.toString()), () {})));
    });
  }

  void editProduct(
      Map<String, dynamic> data, String catId, String id, Object? file) {
    ProductsRepo repo = ProductInjects.addProduct(
        dataModel: data, categoryId: catId, file: file);

    emit(state.copyWith(feadState: DataSourceBaseState.loading()));
    repo.updateData(id).then((value) {
      emit(state.copyWith(feadState: DataSourceBaseState.success("done ")));
    }).catchError((e) {
      emit(state.copyWith(
          feadState: DataSourceBaseState.failure(
              ErrorStateModel(message: e.toString()), () {})));
    });
  }

// delete
  void deleteProduct(String catId, String id) {
    ProductsRepo repo = ProductInjects.deleteProduct(
      categoryId: catId,
    );

    emit(state.copyWith(feadState: DataSourceBaseState.loading()));
    repo.deleteData(id).then((value) {
      emit(state.copyWith(feadState: DataSourceBaseState.success("done ")));
    }).catchError((e) {
      emit(state.copyWith(
          feadState: DataSourceBaseState.failure(
              ErrorStateModel(message: e.toString()), () {})));
    });
  }

// get the list of the data
  void getProductsList(String id , String len ) {
    emit(state.copyWith(feadState: DataSourceBaseState.init()));

    ProductsRepo repo = ProductInjects.getProductRepo(id);
    emit(state.copyWith(listState: DataSourceBaseState.loading()));
    repo.getListData().then((value) {
      if (value.error != null) {
        emit(state.copyWith(
            listState: DataSourceBaseState.failure(
                ErrorStateModel(message: value.error!.toString()), () {})));
      } else {
        var data = value.data!
            .map((e) => ProductViewDataModel(
                  image: e.image,
                  name: e.name,
                  cardData: e.cardData,
                  id: e.id,
                  language: e.language,
                ))
            .toList();
// filter the data by language
        data = data.where((element) => element.language ==  len ).toList();
        emit(state.copyWith(listState: DataSourceBaseState.success(data)));
      }
    }).catchError((e) {
      emit(state.copyWith(
          listState: DataSourceBaseState.failure(
              ErrorStateModel(message: e.toString()), () {})));
    });
  }
}
