
import 'package:JoDija_view/project_configrations/app_configration.dart';
import 'package:JoDija_view/util/localization/loaclized_init.dart';
import 'package:JoDija_view/util/navigations/navigation_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:Mashair/screens/card_drow/mobile/card_draw.dart';
import 'package:Mashair/screens/category_screen/category_screen.dart';
import 'package:Mashair/screens/profile_screen/profile_screen.dart';
import 'package:mashir_service/configration.dart';
import 'ai_configs.dart';
import 'consts/views/assets.dart';
import 'loclization/app_localizations.dart';
import 'loclization/app_localizations_ar.dart';
import 'loclization/app_localizations_en.dart';
import 'screens/auth_screens/log_in_screen.dart';
import 'screens/home_screen/home_screen.dart';
import 'screens/splashScreen.dart';
import 'screens/idea_screen/idea_screen.dart';
class AppConfigration  extends LogicConfigration implements DataViewConfigraion{
// single tone

String aikey  = "";
    static final AppConfigration _singleton = AppConfigration._internal();
    factory AppConfigration() {
      return _singleton;
    }
    AppConfigration._internal(){
      super.setAppConfigration(ServiceEnvType.dev, SerViceAppType.Dashboard, SerViceBackendState.remote_dev);
      super.FirebaseInit(MyConfigAssets.firebaseConfig);
      super.backendRoutedInit(MyConfigAssets.BaseUrl);
   RouteInit();
    }
Future<String >   getaikey()   async {
     return   await   AIConfigs().getApiKey(MyConfigAssets.AIKey);
    }
  @override
  String AppName = "Mashair App";

  @override
  String AppNameID = "Commerce_App";
  @override
  String Version = " V:  1.0.0";
  @override
  Widget launchScreen() {

return Splashscreen();
  }

  @override
  void setAppLocal(String localCode) {
    LocalizationConfig localizationConfig =
    LocalizationConfig(localizedValues: {
      'ar': AppLocalizationsAr(),
      'en': AppLocalizationsEn(),
    });
    localizationConfig.setLocale(Locale(localCode));
    Translation().getlocal();

  }

  @override
  void RouteInit() {
    NavigationService().setRouters(getRouters());
  }

  @override
  Map<String, Widget> getRouters() {
   return  {
      HomeScreen.routeName : HomeScreen(),
      '/login': LogInScreen(),
      CategoryScreen.routeName: CategoryScreen(),
      ProfileScreen.routeName: ProfileScreen(),
     Splashscreen.routeName: Splashscreen(),

     IdeaScreen.routeName: IdeaScreen(),
    };
  }
}
