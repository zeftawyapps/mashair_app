import 'package:JoDija_view/theams/colors/colors.dart';
import 'package:JoDija_view/theams/decorations/docorations.dart';
import 'package:JoDija_view/util/navigations/navigation_service.dart';
import 'package:JoDija_view/util/validators/email_validator.dart';
import 'package:JoDija_view/util/validators/required_validator.dart';
import 'package:JoDija_view/util/widgits/input_form_validation/form_validations.dart';
import 'package:JoDija_view/util/widgits/input_form_validation/widgets/text_form_vlidation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:Mashair/consts/views/colors.dart';

import '../../../app-configs.dart';
import '../../../bloc/auth_bloc.dart';
import '../../../consts/views/assets.dart';
import '../../../consts/views/decoration.dart';
import '../../../consts/views/icons/inputs_icons.dart';
import '../../../loclization/app_localizations.dart';

class LogInForm extends StatefulWidget {
   LogInForm({super.key , this.isloading = false});
  bool isloading = false;

  @override
  State<LogInForm> createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  ValidationsForm form = ValidationsForm();
  TextEditingController emailContrall = TextEditingController();
  TextEditingController passContrall = TextEditingController();

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
              prefixIcon: Icon(
                Inputs.mail_outline,
                color: Theme.of(context).primaryColor.withOpacity(0.5),
              ),
            ),
            controller: emailContrall,
            form: form,
            baseValidation: [EmailValidator(), RequiredValidator()],
            textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 20),
            labalText: Translation().translate().email,

            keyData: "email",
          ),
        ).animate().fadeIn(delay: Duration(milliseconds: 200)),
        SizedBox(
          height: 20.h,
        ),
        Container(
            decoration: MyDecorations(context).card(),
            child: TextFomrFildValidtion(
              decoration: InputDecoration(
                labelStyle: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 15),
                prefixIcon: Icon(Inputs.lock_1),
              ),
              controller: passContrall,
              form: form,
              onFieldSubmitted: (v) {
                // onSubmitted();
              },
              baseValidation: [RequiredValidator()],
              textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 20),
              labalText: Translation().translate().password,
              keyData: "pass",
              isPssword: true,
            )).animate().fadeIn(delay: Duration(milliseconds: 150)),
        SizedBox(
          height: 5.h,
        ),
        GestureDetector(
          child: Container(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                textAlign: TextAlign.left,
                Translation().translate().forgotPassword,
                style: Theme.of(context).textTheme.displaySmall!,
              ),
            ),
          ),
        ).animate().fadeIn(delay: Duration(milliseconds: 100)),
        SizedBox(
          height: 10.h,
        ),
        MaterialButton(
          onPressed: () {
         // NavigationService().replacementToPage( path: '/home');

            var data =form.getInputData();
            AuthBloc().signIn(map: data );
          },
          child:
           widget.isloading ? CircularProgressIndicator() :

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50 ),
            child: Container(
              height: 50.h,

              decoration: MyDecorations(context).botton(),
              child: Center(
                child: Text(
                  Translation().translate().signIn,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.white, fontSize: 14.sp),
                ),
              ),
            ),
          ),
        ) ,
      ]),
    );
  }
}
