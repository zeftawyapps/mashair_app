import 'package:Mashair/loclization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:Mashair/drow_engen/core/shapes/text/text_property.dart';
class QRTextEditor extends StatefulWidget {
  QRTextEditor({super.key , this.text , this.title = 'ادخل الرابط' , this.text2 = 'الصق رابط هنا' });
  String title = "اضفالنص";
  String text2 = 'اضفالنص';
  String? text ;

  @override
  State<QRTextEditor> createState() => _QRTextEditorState();
}

class _QRTextEditorState extends State<QRTextEditor> {
 TextEditingController textEditingController = TextEditingController();

 @override
  void initState() {
    // TODO: implement initState
widget.title = Translation().translate().DrowEngetTextEnterLink;
widget.text2 = Translation().translate().DrowEngetTextPastLinkHere;
   super.initState();
  }
  @override
  Widget build(BuildContext context) {
    textEditingController.text = widget.text ?? '';

   bool iskeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return  SingleChildScrollView(
      child: Container(
        height: iskeyboard ? 0 : 180,
        padding: EdgeInsets.symmetric(horizontal: 10),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text( widget.title, style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold) ,
            ),
            SizedBox(height: 10,),
            Container(
              child: TextField(
                controller: textEditingController,

                decoration: InputDecoration(
                  hintText:  widget.text2,
                ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  String text = textEditingController.text;
                  Navigator.of(context).pop(
                    Texting( text),
                  );
                }
              , child: Text( Translation().translate().Ok)
              ),
      
            )
      
      
          ],
      
        ),
      ),
    );

  }
}
