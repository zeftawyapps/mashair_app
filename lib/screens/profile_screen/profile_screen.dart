import 'dart:io';

import 'package:JoDija_view/util/data_souce_bloc/base_bloc.dart';
import 'package:JoDija_view/util/validators/email_validator.dart';
import 'package:JoDija_view/util/validators/required_validator.dart';
import 'package:JoDija_view/util/widgits/data_source_bloc_widgets/data_source_bloc_listner.dart';
import 'package:JoDija_view/util/widgits/images_widgets/add_image.dart';
import 'package:JoDija_view/util/widgits/input_form_validation/form_validations.dart';
import 'package:JoDija_view/util/widgits/input_form_validation/widgets/text_form_vlidation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Mashair/bloc/auth_bloc.dart';
import 'package:Mashair/consts/views/assets.dart';
import 'package:Mashair/consts/views/decoration.dart';
import 'package:Mashair/drow_engen/core/shapes/avatarwork_image/image_picker/add_image.dart';
import 'package:Mashair/drow_engen/init.dart';
import 'package:mashir_service/data/model/user.dart';

import '../../consts/views/icons/inputs_icons.dart';
import '../../loclization/app_localizations.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static const routeName = '/profile-screen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ValidationsForm form = ValidationsForm();
  TextEditingController emailContrall = TextEditingController();
 // name and phone
  TextEditingController nameContrall = TextEditingController();
  TextEditingController phoneContrall = TextEditingController();
  AuthBloc authBloc = AuthBloc();
 UserData? user ;
 File ? image ;

  @override
  void initState() {
    // TODO: implement initState
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
                  child: DataSourceBlocListener< UserData> (
                   bloc: authBloc.userBloc ,
                    loading: ( ) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    success: (data) {
                      if (data != null) {
                        Navigator.pop(context);
                      }
                    },
                    failure: (error, callback) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(error.message),
                      ));
                    },

                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                                    Container(
                    padding: EdgeInsets.only(bottom: 50),
                    width: double.infinity,
                    decoration: MyDecorations(context).ProfileBar(),
                    child: Column(
                      children: [
                        // add icon button
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          height: 50.h,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        ),


                        ImagePecker(
                          onImage: (v) {
                            image = v.fileImage;
                          },
                          networkImage: user!.image ,
                          place: MyAsset.profile,
                          width: 200.w,
                          hight: 200.h,
                          iconSize: 40,
                          iconPossiontRight: 30,
                          iconPossiontBottom: 0,
                          icon: Icons.edit_outlined,

                          iconContainerColor: Colors.white,
                          imageColor:  Colors.white.withOpacity(0.5),
                          border: Border.all(color: Colors.white, width: 5),
                          iconBorder:  Border.all(
                                           color: Colors.white, width: 5),
                          iconShaw: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                            ),],
                          shape: BoxShape.circle,
                          iconColor: Theme.of(context).primaryColor,
                        ),
                        Container(

                          child: Text(
                           user!.name?? "مستخدم",
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                                    ),
                                    Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.h),
                    child:
                        form.buildChildrenWithColumn(context: context, children: [
                      Container(
                        decoration: MyDecorations(context).Profilecard(),
                        child: TextFomrFildValidtion(
                          decoration: InputDecoration(
                            labelStyle: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 15),

                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 0,
                              ),
                              borderRadius: BorderRadius.circular(50.sp),
                            ),
                            prefixIcon: Icon(Icons.edit_calendar_sharp),
                          ),
                          controller: nameContrall,
                          initValue: user!.name??"",
                          form: form,
                          baseValidation: [RequiredValidator()],
                          textStyle: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(fontSize: 15.sp),
                          labalText: Translation().translate().client,
                          keyData: "name",
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        decoration: MyDecorations(context).card(),
                        child: TextFomrFildValidtion(
                          decoration: InputDecoration(
                              labelStyle: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 15),

                              prefixIcon: Icon(Inputs.mail_outline)),
                          controller: emailContrall,
                          isReadOnly: true ,
                          form: form,

                          baseValidation: [EmailValidator(), RequiredValidator()],
                          textStyle: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(fontSize: 15.sp),
                          initValue: user!.email??"",
                          labalText: Translation().translate().email,
                          keyData: "email",
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        decoration: MyDecorations(context).card(),
                        child: TextFomrFildValidtion(
                          decoration: InputDecoration(
                            labelStyle: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 15),

                            prefixIcon: Icon(Inputs.phone_handset),
                          ),
                          controller: phoneContrall,
                          textInputType: TextInputType.phone,
                          initValue: user!.phone??"",
                          form: form,
                          baseValidation: [  RequiredValidator()],
                          textStyle: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(fontSize: 15.sp),
                          labalText: Translation().translate().clientPhone,
                          keyData: "phone",
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
                          // onSubmitted( );
                       Map<String , dynamic >     data = form.getInputData();
                          if (data.isEmpty) {
                            return;
                          }
                          UserData datauser = UserData.fromJson(data);
                          authBloc.setProfileChange(map: datauser , file: image   ,uid: user!.uid!);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: Container(
                            height: 50.h,
                            decoration: MyDecorations(context).botton(),
                            child: Center(
                              child: Text(
                                Translation().translate().edit,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: Colors.white),
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
