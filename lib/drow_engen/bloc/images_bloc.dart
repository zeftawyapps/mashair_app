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
import 'package:mashir_service/data/model/offers.dart';
import 'package:mashir_service/data/repo/category_repo.dart';
import 'package:mashir_service/data/repo/images_repo.dart';
import 'package:mashir_service/data/repo/offers_repo.dart';

import '../data/images.dart';

class ImagesBloc extends Cubit<FeaturDataSourceState<Images>> {
  late ImagesRepo repoSticker;
  late ImagesRepo repoBackground;
  ImagesBloc() : super(FeaturDataSourceState<Images>.defaultState()) {}
  void setImagesSticker(Images data, Object file) {
    repoSticker = StickerInjects.injectSticker();

    emit(state.copyWith(feadState: DataSourceBaseState.loading()));
    repoSticker.addData(file, data).then((value) {
      emit(state.copyWith(feadState: DataSourceBaseState.success("done ")));
    }).catchError((e) {
      emit(state.copyWith(
          feadState: DataSourceBaseState.failure(
              ErrorStateModel(message: e.toString()), () {})));
    });
  }

  void setImagesBackground(Images data, Object file) {
    repoBackground = BackgroundInjects.injectBackground();
    emit(state.copyWith(feadState: DataSourceBaseState.loading()));
    repoBackground.addData(file, data).then((value) {
      emit(state.copyWith(feadState: DataSourceBaseState.success("done ")));
    }).catchError((e) {
      emit(state.copyWith(
          feadState: DataSourceBaseState.failure(
              ErrorStateModel(message: e.toString()), () {})));
    });
  }

  void deleteSticker(String id) {
    repoSticker = StickerInjects.injectSticker();

    emit(state.copyWith(feadState: DataSourceBaseState.loading()));
    repoSticker.deleteData(id).then((value) {
      emit(state.copyWith(feadState: DataSourceBaseState.success("done ")));
    }).catchError((e) {
      emit(state.copyWith(
          feadState: DataSourceBaseState.failure(
              ErrorStateModel(message: e.toString()), () {})));
    });
  }

  void deleteBackground(String id) {
    repoBackground = BackgroundInjects.injectBackground();
    emit(state.copyWith(feadState: DataSourceBaseState.loading()));
    repoBackground.deleteData(id).then((value) {
      emit(state.copyWith(feadState: DataSourceBaseState.success("done ")));
    }).catchError((e) {
      emit(state.copyWith(
          feadState: DataSourceBaseState.failure(
              ErrorStateModel(message: e.toString()), () {})));
    });
  }

  void setImagesAvatar(Images data, Object file) {
    repoSticker = AvatarInjects.injectAvatar();

    emit(state.copyWith(feadState: DataSourceBaseState.loading()));
    repoSticker.addData(file, data).then((value) {
      emit(state.copyWith(feadState: DataSourceBaseState.success("done ")));
    }).catchError((e) {
      emit(state.copyWith(
          feadState: DataSourceBaseState.failure(
              ErrorStateModel(message: e.toString()), () {})));
    });
  }

  void deleteAvatar(String id) {
    repoSticker = AvatarInjects.injectAvatar();

    emit(state.copyWith(feadState: DataSourceBaseState.loading()));
    repoSticker.deleteData(id).then((value) {
      emit(state.copyWith(feadState: DataSourceBaseState.success("done ")));
    }).catchError((e) {
      emit(state.copyWith(
          feadState: DataSourceBaseState.failure(
              ErrorStateModel(message: e.toString()), () {})));
    });
  }

  void getImagesSticker() {
    repoSticker = StickerInjects.injectSticker();
    emit(state.copyWith(feadState: DataSourceBaseState.init()));
    emit(state.copyWith(listState: DataSourceBaseState.loading()));
    repoSticker.getListData().then((value) {
      List<Images> list = [];

      value.data!.forEach((element) {
        list.add(Images(image: element.image, id: element.id));
      });

      emit(state.copyWith(listState: DataSourceBaseState.success(list)));
    }).catchError((e) {
      emit(state.copyWith(
          listState: DataSourceBaseState.failure(
              ErrorStateModel(message: e.toString()), () {})));
    });
  }

  void getImagesAvatar() {
    repoSticker = AvatarInjects.injectAvatar();
    emit(state.copyWith(feadState: DataSourceBaseState.init()));
    emit(state.copyWith(listState: DataSourceBaseState.loading()));
    repoSticker.getListData().then((value) {
      List<Images> list = [];
      value.data!.forEach((element) {
        list.add(Images(image: element.image, id: element.id));
      });
      emit(state.copyWith(listState: DataSourceBaseState.success(list)));
    }).catchError((e) {
      emit(state.copyWith(
          listState: DataSourceBaseState.failure(
              ErrorStateModel(message: e.toString()), () {})));
    });
  }

  void getImagesBackground() {
    repoBackground = BackgroundInjects.injectBackground();
    emit(state.copyWith(feadState: DataSourceBaseState.init()));
    emit(state.copyWith(listState: DataSourceBaseState.loading()));
    repoBackground.getListData().then((value) {
      List<Images> list = [];

      value.data!.forEach((element) {
        list.add(Images(image: element.image, id: element.id));
      });
      emit(state.copyWith(listState: DataSourceBaseState.success(list)));
    }).catchError((e) {
      emit(state.copyWith(
          listState: DataSourceBaseState.failure(
              ErrorStateModel(message: e.toString()), () {})));
    });
  }
  void getImagesEvents() {
    repoBackground =  EventsInjects.injectEvent();
    emit(state.copyWith(feadState: DataSourceBaseState.init()));
    emit(state.copyWith(listState: DataSourceBaseState.loading()));
    repoBackground.getListData().then((value) {
      List<Images> list = [];

  var data =      value.data!.first ;
      emit(state.copyWith(itemState: DataSourceBaseState.success(Images(image: data.image, id: data.id))));
    }).catchError((e) {
      emit(state.copyWith(
          listState: DataSourceBaseState.failure(
              ErrorStateModel(message: e.toString()), () {})));
    });
  }




  void setImagesEvent (Images data, Object file) {
    repoBackground = EventsInjects.injectEvent();
    emit(state.copyWith(feadState: DataSourceBaseState.loading()));
    repoBackground.addDataWithId(file, data,"ev1").then((value) {
      emit(state.copyWith(feadState: DataSourceBaseState.success("done ")));
    }).catchError((e) {
      emit(state.copyWith(
          feadState: DataSourceBaseState.failure(
              ErrorStateModel(message: e.toString()), () {})));
    });
  }



}
