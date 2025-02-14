import 'package:JoDija_view/theams/colors/colors.dart';
import 'package:JoDija_view/theams/decorations/docorations.dart';
import 'package:JoDija_view/util/validators/email_validator.dart';
import 'package:JoDija_view/util/validators/required_validator.dart';
import 'package:JoDija_view/util/widgits/input_form_validation/form_validations.dart';
import 'package:JoDija_view/util/widgits/input_form_validation/widgets/text_form_vlidation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Mashair/bloc/auth_bloc.dart';
import 'package:Mashair/consts/views/colors.dart';
import 'package:mashir_service/data/model/user.dart';

import '../../../app-configs.dart';
import '../../../consts/views/decoration.dart';
import '../../../consts/views/icons/inputs_icons.dart';
import '../../../loclization/app_localizations.dart';

class SigneUpForm extends StatefulWidget {
  const SigneUpForm({super.key});

  @override
  State<SigneUpForm> createState() => _SigneUpFormState();
}

class _SigneUpFormState extends State<SigneUpForm> {
  ValidationsForm form = ValidationsForm();
  TextEditingController emailContrall = TextEditingController();
  TextEditingController passContrall = TextEditingController();
  TextEditingController nameContrall = TextEditingController();
  TextEditingController phoneContrall = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),

      child: form.buildChildrenWithColumn(context: context, children: [

        Container(

          decoration: MyDecorations(context).card(),
          child: TextFomrFildValidtion(
            decoration: InputDecoration(
              labelStyle: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 15),
              prefixIcon: Icon(Inputs.person_outline ),
            ) ,
            controller: nameContrall,
            form: form,
            baseValidation: [ RequiredValidator()],
            textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 15.sp),
            labalText: Translation().translate().client,
            keyData:   "name",
          ),
        ).animate().fadeIn(delay: Duration(milliseconds: 200)),
        SizedBox(
          height: 10.h,
        ),
        Container(
          decoration: MyDecorations(context).card(),
          child: TextFomrFildValidtion(
            decoration: InputDecoration(
                labelStyle: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 15),
              prefixIcon: Icon(Inputs.mail_outline  )
            ) ,
            controller: emailContrall,
            form: form,
            textInputType: TextInputType.emailAddress,
            baseValidation: [EmailValidator(), RequiredValidator()],
            textStyle: Theme.of(context).textTheme.displayMedium! .copyWith(fontSize: 15.sp ),
            labalText: Translation().translate().email,
            keyData: "email",
          ),
        ).animate().fadeIn(delay: Duration(milliseconds: 200)),
        SizedBox(
          height: 10.h,
        ),
        Container(
          decoration: MyDecorations(context).card(),
          child: TextFomrFildValidtion(
            decoration: InputDecoration(
              labelStyle: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 15),
              prefixIcon: Icon(Inputs.phone_handset ),
            ) ,
            controller: phoneContrall,
            form: form,
            textInputType: TextInputType.phone,
            baseValidation: [ RequiredValidator()],
            textStyle: Theme.of(context).textTheme.displayMedium! .copyWith(fontSize: 15.sp ),
            labalText: Translation().translate().clientPhone,
            keyData: "phone",
          ),
        ).animate().fadeIn(delay: Duration(milliseconds: 200)),
        SizedBox(
          height: 10.h,
        ),
        Container(
            decoration: MyDecorations(context).card(),
            child: TextFomrFildValidtion(


              decoration: InputDecoration(
                labelStyle: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 15),

                prefixIcon: Icon(Inputs.lock_1),

              ) ,
              controller: passContrall,
              form: form,
              onFieldSubmitted: (v) {
                // onSubmitted();
              },
              baseValidation: [RequiredValidator()],
              textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 15.sp),
              labalText: Translation().translate().password,
              textInputType: TextInputType.visiblePassword,
              keyData: "pass",
              isPssword: true,
            )).animate().fadeIn(delay: Duration(milliseconds: 150)),
              SizedBox(
          height: 10.h,
        ),
        MaterialButton(
          onPressed: () {
           onSubmitted( );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Container(
              height: 50.h,
              decoration: MyDecorations(context).botton(),
              child: Center(
                child: Text(
                  Translation().translate().signUp,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ).animate().fadeIn(delay: Duration(milliseconds: 50)),
      ]),
    );
  }

  void onSubmitted() {
   var data =form.getInputData();
   AuthBloc().signUp(map: data);
  }
}
