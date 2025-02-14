
import 'package:JoDija_view/util/data_souce_bloc/base_bloc.dart';
import 'package:mashir_service/data/logic_injicts.dart';

import 'package:mashir_service/data/model/suggesment_model.dart';


class SuggestBloc {
  // single tone
  static final SuggestBloc _singleton = SuggestBloc._internal();
  factory SuggestBloc() {
    return _singleton;
  }
  SuggestBloc._internal() ;
     DataSourceBloc<SuggetModel> bloc = DataSourceBloc<SuggetModel>();
  void setSuggest({required Map<String, dynamic> map}) async {

      bloc.loadingState();
      var user = SuggetModel.fromJson(map);
      var repo = SuggestmentInjects.injectSuggestment();
      var result  =  await  repo.addSuggestment(user);
 if (result.error != null) {

    } else {
      bloc.successState(result.data);
    }

  }

}