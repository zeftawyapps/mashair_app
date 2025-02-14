import 'package:JoDija_view/util/app_settings/settings_inherted.dart';
import 'package:JoDija_view/util/localization/loaclized_init.dart';
import 'package:JoDija_view/util/navigations/animation_types.dart';
import 'package:JoDija_view/util/navigations/navigation_service.dart';
import 'package:Mashair/screens/card_drow/mobile/widgets/ai/ai_cubit.dart';
import 'package:devicelocale/devicelocale.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Mashair/bloc/auth_bloc.dart';
import 'package:Mashair/drow_engen/bloc/images_bloc.dart';
import 'package:Mashair/drow_engen/core/bloc/main_bloc/main_bloc.dart';
import 'package:provider/provider.dart';
import 'app-configs.dart';
import 'bloc/cat_bloc.dart';
import 'bloc/prod_bloc.dart';
import 'consts/views/themes.dart';
import 'drow_engen/core/bloc/print_bloc/print_bloc.dart';
import 'drow_engen/init.dart';


class AppLouncher extends StatelessWidget {
  const AppLouncher({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    init();
    return ScreenUtilInit(
        minTextAdapt: true,
        designSize: const Size(375, 812),
        builder: (context, Widget? child) {
          NavigationService ns = NavigationService();
          ns.animationType = AnimationType.slide;
          return MultiBlocProvider(

            providers: [
              BlocProvider<CategoryBloc>(
                create: (BuildContext context) => CategoryBloc(),
              ),
              BlocProvider(create: (BuildContext context) => DrawEngineMainBloc()),

              BlocProvider<ProductBloc>(
                create: (BuildContext context) => ProductBloc(),
              ),
              BlocProvider(create: (BuildContext context) => DrawEngineMainBloc()),
              BlocProvider(create: (BuildContext context) => DrawEnginePrintBloc()),
              BlocProvider(create: (BuildContext context) => ImagesBloc()),
              BlocProvider(create: (BuildContext context) => AiCubit())

            ],
            child: SettingChanger(

              child: Builder(
                builder: (context) {

                  var sitteng = SettingChangeLestner.of(context).state;
                  // sitteng.language =  "ar";
                  sitteng.theme= ThemeMode.light ;
                  String lan = sitteng!.language!;
                   AppConfigration().setAppLocal( lan );

                  // Devicelocale.currentLocale.then((value) {
                  //       String   l  = value!.substring(0,2);
                  //       bool isAr = l == "ar";
                  //      AppConfigration().setAppLocal( isAr ?"ar" : "en");
                  // });



                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    navigatorKey: ns.navigatorKey,
                    onGenerateRoute: ns.generateRoute,
                    supportedLocales: AppLocalizationsInit().supportedLocales,
                    locale: AppLocalizationsInit().local,
                    localizationsDelegates:
                    AppLocalizationsInit().localizationsDelegates,
                    theme: Themes(context).light(),
                    darkTheme: Themes(context).dark(),
                    themeMode:  sitteng.theme,
                    home: AppConfigration().launchScreen(),

              
                  );
                }
              ),
            ),
          );
        }
    );
  }
}
