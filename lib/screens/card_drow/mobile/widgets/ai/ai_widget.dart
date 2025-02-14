import 'package:JoDija_view/theams/colors/colors.dart';
import 'package:JoDija_view/util/app_settings/settings_inherted.dart';
import 'package:Mashair/loclization/app_localizations.dart';
import 'package:Mashair/screens/card_drow/mobile/widgets/ai/ai_cubit.dart';
import 'package:Mashair/widgets/laoding.dart';
import 'package:Mashair/widgets/loading2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../consts/views/colors.dart';

class AiWidget extends StatefulWidget {
  const AiWidget({super.key});

  @override
  State<AiWidget> createState() => _AiWidgetState();
}

class _AiWidgetState extends State<AiWidget> {
  late TextEditingController controller;
  int aiState = 0;
  AiCubit aiCubit = AiCubit();
  List<String> generatedText = [];
  bool isVlidationError = false;
  String textError = "";
  @override
  void initState() {
    // TODO: implement initState
    controller = TextEditingController();
    aiCubit = context.read<AiCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AiCubit, AiState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case AiInitial:
            setState(() {
              aiState = 0;
            });
            break;
          case AiLoading:
            setState(() {
              aiState = 1;
            });
            break;
          case AiGenerated:
            setState(() {
              aiState = 2;
            });
            break;
          case AiListPhraseGenarted:
            var stateData = state as AiListPhraseGenarted;

            setState(() {
              // filter the text list if text len < 3 egnor it
              generatedText = stateData.generatedText
                  .where((element) => element.length > 3)
                  .toList();
              aiState = 2;
            });
            break;
          case AiError:
            setState(() {
              var stateData = state as AiError;
              textError = stateData.errorMessage;
              aiState = 3;
            });
            break;
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        color: Colors.white,
        child: Column(children: [
          Visibility(
            visible: aiState == 0,
            child: Container(
              height: 100.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: TextField(

                      // add decoration
                      decoration: InputDecoration(
                        hintText:
                            Translation().translate().writeWhatYouWantHere,
                        hintStyle: TextStyle(
                          color: LightColors().hintText,
                          fontSize: 20,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: LightColors().primary),
                        ),
                      ),
                      controller: controller,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: MaterialButton(
                      onPressed: () {
                        if (controller.text.isEmpty) {
                          setState(() {
                            isVlidationError = true;
                          });
                          return;
                        }

                        isVlidationError = false;
                        var sitteng = SettingChangeLestner.of(context).state;
                        String lang = sitteng!.language!;

                        aiCubit.addPrompet(controller.text, lang: lang);
                      },
                      child: Icon(
                        Icons.send,
                        size: 40,
                        color: LightColors().primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // error validation text
          Visibility(
            visible: isVlidationError,
            child: Text(
              "يجب ادخال النص",
              style: TextStyle(
                color: Colors.red,
                fontSize: 20,
              ),
            ),
          ),

          Visibility(
              visible: aiState == 1,
              child: Container(
                  height: 100.h,
                  child: Loading2(
                    color: LightColors().primary,
                  ))),
          Visibility(
            visible: aiState == 2,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Wrap(
                    children: generatedText
                        .map((e) => Container(
                              padding: EdgeInsets.only(
                                  bottom: 10, right: 10, left: 10),
                              child: GestureDetector(
                                      onTap: () {
                                        aiCubit.chosePrompet(e);
                                      },
                                      child: Text(
                                        e,
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: LightColors().primary,
                                        ),
                                      ))
                                  .animate()
                                  .fadeIn(
                                      duration: Duration(milliseconds: 500)),
                            ))
                        .toList(),
                  ),
                  Container(
                    height: 50.h,
                    child: Row(
                      children: [
                        Expanded(
                          child: MaterialButton(
                            onPressed: () {
                              aiCubit.addPrompet(controller.text);
                            },
                            child: Icon(
                              Icons.refresh,
                              size: 40,
                              color: LightColors().primary,
                            ),
                          ),
                        ),
                        Expanded(
                          child: MaterialButton(
                            onPressed: () {
                              setState(() {
                                aiState = 0;
                              });
                            },
                            child: Icon(
                              Icons.close,
                              size: 40,
                              color: LightColors().primary,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
              child: Text(
                textError,
                style: TextStyle(
                  fontSize: 20,
                  color: LightColors().primary,
                ),
              ),
              visible: aiState == 3),
        ]),
      ),
    );
  }
}
