import 'package:JoDija_view/util/jsonengen/json_asset_reader.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import 'consts/views/assets.dart';

class AIConfigs {
  String apiKey = "";
late   GenerativeModel  model ;
late GenerateContentResponse response;
Future<String> getApiKey(String path) async {
    var data = await JsonAssetReader(path: path).data;
    var aiconfig = data['ai_keys'];
    apiKey = aiconfig['gen_key'];
    return apiKey;
  }

void aiConfiginit () async {
    apiKey = await getApiKey(MyConfigAssets.AIKey);
model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: apiKey,
    );
  }
  void aiOprationTest() async {
    String aikey = await getApiKey(MyConfigAssets.AIKey);
    print(aikey);
    final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: aikey,
    );

    final prompt = ' هذا تطبيق يعبر فيه المستخدم عن مشاعره اريدك ان تكبت لي عبارات اعبر فيها عن حبي لامي بحيث تكون العبارات تبدا '
        ' ب علاقمة ** وتنتهي بعلامة ** '
        'وتكون العبارات باللغة العربية'
        'قبل كتابة العبارات ابداها برمز @@ '
        'وتنتهي برمز //';

    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);


    print(response.text );
  }


  String getTextPrompt(String prompt) {


  if (prompt == "") {
      prompt = " اريد ان اعبر عن حبي لزوجتي ";
    }

  String mainText =  ' هذا تطبيق يعبر فيه المستخدم عن مشاعره '
      +prompt+
      ' بحيث تكون العبارة تفضل بينها علامة  '
      '  ** '
      'وتكون العبارات باللغة العربية'
  'في حالة عدم فهمك  عبارة '
  +prompt+
    'ارسل لي عبارة واحدة فقط عن الحب و المشاعر '
        ' بحيث تكون العبارات تفضل بينها علامة  '
        '  ** '
  ;

    return mainText;
  }
  String getTextPromptEn(String prompt) {


    if (prompt == "") {
      prompt = "I want to express my love for my wife";
    }

    String mainText =  ' This is an application in which the user expresses his feelings '
        +prompt+
        ' so that the phrase is preferred between the mark '
        '  ** '
        'The phrases are in English '
        'If you do not understand a phrase '
        +prompt+
        'Send me only one phrase about love and feelings '
        ' so that the phrase is preferred between the mark '
        '  ** '
    ;

    return mainText;
  }


Future<GenerateContentResponse> aiOpration(String prompt) async {
    final content = [Content.text(prompt)];
    response = await model.generateContent(content);
    return response;
  }
String getGeneratedText(GenerateContentResponse response) {
    if (response.text != null) {
      return response.text!;
    } else {
      return "";
    }
  }

  List<String>getGeneratedTextList(String  text ) {
    List<String> textList = [];
    if ( text  != null) {
      textList = response.text!.split("**");
    }
    return textList;
  }


}