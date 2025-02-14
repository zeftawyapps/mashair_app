import 'dart:async';

import 'package:JoDija_DataSource/https/http_urls.dart';
 import 'package:JoDija_view/util/navigations/navigation_service.dart';
import 'package:JoDija_view/util/shardeprefrance/shard_check.dart';
import 'package:JoDija_view/util/widgits/screen_provider/screen_notfier.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:Mashair/screens/auth_screens/log_in_screen.dart';
import 'package:Mashair/screens/home_screen/home_screen.dart';
import 'package:mashir_service/data/model/user.dart';

import '../../bloc/auth_bloc.dart';

class SplashScreenLogic extends ScreenStateNotifier {
  bool login = false;

  late Timer _timer;

  void timer() async {
    try {
      _timer = Timer(Duration(seconds: 5), () {
        SharedPrefranceChecking sharedPrefranceChecking =
            SharedPrefranceChecking();
        sharedPrefranceChecking.IsUserRejised(
            isRegistAction: (s) async {
              if (login) {
                return;
              }
              AuthBloc authBloc = AuthBloc();
              var result = await authBloc.signeInFromTimer(
                  map: {authBloc.emailKey: s.email, authBloc.passKey: s.pass});
              result.pick(onData: (v) {
              authBloc.user =  UserData.fromJson(v.map);
              authBloc.user!.uid = v.uid??"" ;
              authBloc.user!.image = v.map["imguri"]??"";
                sharedPrefranceChecking.setDataInShardRefrace(
                    email: s.email!, pass: s.pass!, token: v.token!);
                HttpHeader().setAuthHeader(v.token!, Bearer: "Bearer__");
                // NavigationService().replacementPage(path: MainScreen());
              }, onError: (error) {
                print(error);
              });

              HttpHeader().setAuthHeader(s.token!, Bearer: "Bearer__");
              NavigationService().replacementPage(path: HomeScreen());
            },
            NotRegistAction: () =>
                {NavigationService().replacementPage(path: LogInScreen())});
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _timer.cancel();
  }

  @override
  void createproviers(BuildContext contxt) {
    // TODO: implement createproviers
  }
}
