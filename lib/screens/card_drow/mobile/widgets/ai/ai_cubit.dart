import 'package:Mashair/ai_configs.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'ai_state.dart';

class AiCubit extends Cubit<AiState> {
  AIConfigs aiConfigs = AIConfigs();
  AiCubit() : super(AiInitial()) {
    aiConfigs.aiConfiginit();
  }

  void addPrompet(String customText , {String  lang = "ar"}) {
    emit(AiLoading());

    aiConfigs.aiOpration( lang == "ar"? aiConfigs.getTextPrompt(customText):
    aiConfigs.getTextPromptEn(customText)
    ).then((value) {
      String text = aiConfigs.getGeneratedText(value);
      if (text.contains(" انا اسف لم") ||
          text.contains("لم افهم ") ||
          text.contains("لم اجد ") ||
          text.contains("لم اعرف ") ||
          text.contains("غير مفهم")  ||
          text .contains("افهم المطوب"))
      {
        emit(AiError(text));
      }

      if (text == "") {
        emit(AiLoading());
      } else {
        emit(AiGenerated(value.text!));

        List<String> list = aiConfigs.getGeneratedTextList(text);
        emit(AiListPhraseGenarted(list));
      }
    }).catchError((e) {
      emit(AiError(e.toString()));
    });
  }

  void chosePrompet(String customText) {
    emit(AiDateChoosed(customText));
  }
}
