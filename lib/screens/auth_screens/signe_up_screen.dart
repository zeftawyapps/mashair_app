import 'package:JoDija_view/util/widgits/data_source_bloc_widgets/data_source_bloc_listner.dart';
import 'package:Mashair/loclization/app_localizations.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Mashair/bloc/auth_bloc.dart';
import 'package:Mashair/screens/auth_screens/form_widgets/log_in_form.dart';
import 'package:Mashair/screens/auth_screens/log_in_screen.dart';
import 'package:Mashair/screens/auth_screens/wave_custom.dart';
import 'package:mashir_service/data/model/user.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../../consts/views/assets.dart';
import '../../widgets/laoding.dart';
import '../home_screen/home_screen.dart';
import '../line.dart';
import 'form_widgets/signe_up_form.dart';

class SigneUpScreen extends StatefulWidget {
  const SigneUpScreen({super.key});

  @override
  State<SigneUpScreen> createState() => _SigneUpScreenState();
}

class _SigneUpScreenState extends State<SigneUpScreen> {

bool isloading = false ;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        body: SafeArea(
          child: DataSourceBlocListener<UserData>(
            bloc: AuthBloc().userBloc,
             loading: ( ) {
                setState(() {
                  isloading = true ;
                });
              },
             success: (data) {
              if (data != null) {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => HomeScreen()));
              }
            },
            failure: (error, callback) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(error.message),
              ));
            }
            ,

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
                            padding: const EdgeInsets.only(
                                top: 10, left: 20, right: 20, bottom: 10),
                            child: Container(
                                    width: 200.w,
                                    height: 70.h,
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Text(
                              Translation().translate().appDescription,
                                       style: Theme.of(context).textTheme.bodySmall,
                                    textAlign: TextAlign.center)
                                .animate()
                                .fadeIn(duration: Duration(milliseconds: 600))
                                .moveY(duration: Duration(milliseconds: 600)),
                          ),
                          SizedBox(
                            height: 7.h,
                          ),
                          SigneUpForm(),
                          SizedBox(
                            height: 10.h,
                          ),
                          // Container(
                          //   child: Row(
                          //     children: [
                          //       Expanded(child: Line()),
                          //       Text("او تسجيل عن طريق ",
                          //               style: Theme.of(context)
                          //                   .textTheme
                          //                   .displaySmall)
                          //           .animate()
                          //           .fadeIn(
                          //               delay: Duration(milliseconds: 500),
                          //               duration: Duration(milliseconds: 600)),
                          //       Expanded(child: Line())
                          //     ],
                          //   ),
                          // ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                // GestureDetector(
                                //   onTap: () {
                                //     AuthBloc().signUpWithGoogle();
                                //   },
                                //   child:isloading ?CircularProgressIndicator(color: Colors.white,) :  Container(
                                //     height: 40.h,
                                //     width: 40.h,
                                //     decoration: BoxDecoration(
                                //       image: DecorationImage(
                                //         image: AssetImage(MyAsset.google),
                                //         fit: BoxFit.cover,
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text( Translation().translate().hoveAccount,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall)
                                    .animate()
                                    .fadeIn(
                                        delay: Duration(milliseconds: 500),
                                        duration: Duration(milliseconds: 600)),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LogInScreen()));
                                  },
                                  child: Text( Translation().translate().signIn,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayLarge!)
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



                ],
              ),
            ),
          ),
        ));
  }
}
