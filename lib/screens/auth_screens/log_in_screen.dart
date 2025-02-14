import 'package:JoDija_view/util/app_settings/settings_inherted.dart';
import 'package:JoDija_view/util/app_settings/settings_model.dart';
import 'package:JoDija_view/util/navigations/navigation_service.dart';
import 'package:JoDija_view/util/widgits/data_source_bloc_widgets/data_source_bloc_listner.dart';
import 'package:Mashair/loclization/app_localizations.dart';
import 'package:devicelocale/devicelocale.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Mashair/screens/auth_screens/form_widgets/log_in_form.dart';
import 'package:Mashair/screens/auth_screens/signe_up_screen.dart';
import 'package:Mashair/screens/auth_screens/wave_custom.dart';
import 'package:Mashair/screens/waves.dart';
import 'package:mashir_service/data/model/user.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../../bloc/auth_bloc.dart';
import '../../consts/views/assets.dart';
import '../../widgets/laoding.dart';
import '../../widgets/loading2.dart';
import '../../widgets/loading3.dart';
import '../home_screen/home_screen.dart';
import '../line.dart';
import 'dart:io';


class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool isloading = false;



  @override
  Widget build(BuildContext context) {

    // get the language from the system


    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        body: SafeArea(
          child: DataSourceBlocListener<UserData>(
           bloc:     AuthBloc().userBloc,
            loading: ( ) {
              setState(() {
                isloading = true ;
              });
            },
            success: (UserData? data) {

              if (data != null) {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => HomeScreen()));
              }

            },
            failure: (error, dynamic Function() callback) {

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(error.message),
              ));

            },
            child: Container(
              child: Stack(
                children: [
                  Wave1Castom() ,
                  SingleChildScrollView(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Container(
                                    width: 270.w,
                                    height: 100.h,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(MyAsset.imglogo),
                                        fit: BoxFit.cover,
                                      ),
                                    ))
                                .animate()
                                .fadeIn(duration: Duration(milliseconds: 1200)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 15, top: 10),
                            child: Text(
                                    Translation().translate().appDescription ,
                                    style: Theme.of(context).textTheme.bodySmall,
                                    textAlign: TextAlign.center)
                                .animate()
                                .fadeIn(duration: Duration(milliseconds: 600))
                                .moveY(duration: Duration(milliseconds: 600)),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          LogInForm(isloading: isloading,),
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                            child: Row(
                              children: [
                                Expanded(child: Line()),

                                Expanded(child: Line())
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text( Translation().translate().hoveNoAccount,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall!.copyWith(
                                          fontSize: 13.sp,
                                        )

                                )
                                    .animate()
                                    .fadeIn(
                                        delay: Duration(milliseconds: 500),
                                        duration: Duration(milliseconds: 600)),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SigneUpScreen()));
                                  },
                                  child: Text( Translation().translate().registWithUs,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayLarge!
                                  .copyWith(
                                    fontSize: 13.sp,
                                            fontWeight: FontWeight.bold,
                                  )
                                  )
                                      .animate()
                                      .fadeIn(
                                          delay: Duration(milliseconds: 500),
                                          duration: Duration(milliseconds: 600)),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ).animate().fadeIn(
                        duration: Duration(milliseconds: 600),
                        delay: Duration(milliseconds: 200)),
                  ),
                  // isloading ?   Loading(isloading: isloading,) : Container()


                ],
              ),
            ),
          ),
        ));
  }



}
