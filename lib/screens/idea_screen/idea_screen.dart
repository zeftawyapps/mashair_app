import 'package:JoDija_view/util/validators/email_validator.dart';
import 'package:JoDija_view/util/validators/required_validator.dart';
import 'package:JoDija_view/util/widgits/data_source_bloc_widgets/data_source_bloc_listner.dart';
import 'package:JoDija_view/util/widgits/input_form_validation/form_validations.dart';
import 'package:JoDija_view/util/widgits/input_form_validation/widgets/text_form_vlidation.dart';
import 'package:Mashair/bloc/suggest_bloc.dart';
import 'package:Mashair/drow_engen/init.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Mashair/consts/views/assets.dart';
import 'package:Mashair/consts/views/decoration.dart';
import 'package:mashir_service/data/model/user.dart';

import '../../bloc/auth_bloc.dart';
import '../../consts/views/icons/inputs_icons.dart';
import '../../loclization/app_localizations.dart';

class IdeaScreen extends StatefulWidget {
  const IdeaScreen({super.key});
  static const routeName = '/idea-screen';

  @override
  State<IdeaScreen> createState() => _IdeaScreenState();
}

class _IdeaScreenState extends State<IdeaScreen> {
  ValidationsForm form = ValidationsForm();
  TextEditingController emailContrall = TextEditingController();
  TextEditingController phoneContrall = TextEditingController();
  TextEditingController massageContrall = TextEditingController();
  AuthBloc authBloc = AuthBloc();
  UserData? user;
  late SuggestBloc blocs;
  bool isLoad = false;
  initState() {
    blocs = SuggestBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = authBloc.user;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              child: Center(
                  child: DataSourceBlocListener(
            bloc: blocs.bloc,
            loading: () {
              setState(() {
                isLoad = true;
              }); // add snak bar
            },
            success: (data) {
              // add snak bar

              Navigator.pop(context);
            },
            failure: (error, dynamic Function() callback) {},
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                height: 100.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 30.sp,
                        color: Colors.black,
                      ),
                    )),
                    Expanded(
                      flex: 10,
                      child: Text(
                        Translation().translate().suggest,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.h),
                child:
                    form.buildChildrenWithColumn(context: context, children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    decoration: MyDecorations(context).Ideacard(),
                    child: TextFomrFildValidtion(
                      initValue: user!.email,
                      decoration: InputDecoration(
                        hintText: Translation().translate().clientEmail,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 0,
                          ),
                          borderRadius: BorderRadius.circular(20.sp),
                        ),
                      ),
                      controller: emailContrall,
                      form: form,
                      baseValidation: [
                        RequiredValidator(),
                        EmailValidator(),
                      ],
                      textStyle: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontSize: 25.sp),
                      keyData: "email",
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    decoration: MyDecorations(context).Profilecard(),
                    child: TextFomrFildValidtion(
                      initValue: user!.phone,
                      decoration: InputDecoration(
                        hintText: Translation().translate().clientPhone,
                      ),
                      controller: phoneContrall,
                      form: form,
                      baseValidation: [RequiredValidator()],
                      textStyle: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontSize: 25.sp),
                      keyData: "phone",
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    decoration: MyDecorations(context).Profilecard(),
                    child: TextFomrFildValidtion(
                      mulitLine: 7,
                      decoration: InputDecoration(
                        hintText: Translation().translate().leaveYourMassage,
                      ),
                      controller: massageContrall,
                      form: form,
                      baseValidation: [RequiredValidator()],
                      textStyle: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontSize: 25.sp),
                      keyData: "massage",
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  MaterialButton(
                    onPressed: () {
                      var data = form.getInputData();
                      print(data);
                      blocs.setSuggest(map: data);

                      massageContrall.text = "";
                      // add snak bar
                      Future.delayed(Duration(milliseconds: 1000));

                      showDialog(
                          context: context,
                          builder: (context) {
                            // add massage to thank the user

                            return AlertDialog(
                              title: Text(Translation()
                                  .translate()
                                  .thankYouForSuggesment),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(Translation().translate().Ok),
                                ),
                              ],
                            );
                          }).then((d) {
                        Navigator.of(context).pop();
                      });

                      // onSubmitted( );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 70),
                      child: Container(
                        height: 50.h,
                        decoration: MyDecorations(context).botton(),
                        child: Center(
                          child: Text(
                            Translation().translate().edit,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: Colors.white, fontSize: 14.sp),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              )
            ]),
          ))),
        ),
      ),
    );
  }
}
