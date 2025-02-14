import 'package:JoDija_DataSource/utilis/models/staus_model.dart';
import 'package:JoDija_view/util/data_souce_bloc/base_bloc.dart';
import 'package:JoDija_view/util/data_souce_bloc/remote_base_model.dart';
import 'package:mashir_service/data/logic_injicts.dart';
import 'package:mashir_service/data/model/home_data.dart';
import 'package:mashir_service/data/repo/landing_repo.dart';

class LandingBloc {
  // single tone
  static final LandingBloc _singleton = LandingBloc._internal();
  factory LandingBloc() {
    return _singleton;
  }
  LandingBloc._internal(){
bloc = DataSourceBloc<LandingPageApiRespons>();
  _getLandingData();
  }
  // late LandingRepo _landingRepo;
  late  DataSourceBloc<LandingPageApiRespons> bloc ;
  void _getLandingData()async {
    bloc.loadingState();
    LandingRepo landingRepo = LandingInjects.injectLanding();
    var respo = await landingRepo.getLandingData();
    Map<String, dynamic> jsondata = respo.data!;
    if (respo.status == StatusModel.success) {
      var data = LandingPageApiRespons.fromJson(jsondata);
      bloc.successState(data );
    } else {
   bloc .failedState(  ErrorStateModel(message: respo.message) , () {});
    }
  }
}