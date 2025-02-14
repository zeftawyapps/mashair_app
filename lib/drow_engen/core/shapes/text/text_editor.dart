import 'package:flutter/material.dart';
import 'package:Mashair/drow_engen/core/shapes/text/text_property.dart';

import '../../../../loclization/app_localizations.dart';
class TextEditor extends StatefulWidget {
  TextEditor({super.key , this.text  , this.title = 'اضفالنص' , this.text2 = 'اضف نص هنا' });
  String? text ;
  String title = "اضفالنص";
  String text2 = 'اضفالنص';

  @override
  State<TextEditor> createState() => _TextEditorState();
}

class _TextEditorState extends State<TextEditor> {
 TextEditingController textEditingController = TextEditingController();

 @override
  void initState() {
    // TODO: implement initState

   super.initState();
  }
  @override
  Widget build(BuildContext context) {
    textEditingController.text = widget.text ?? '';

   bool iskeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return  SingleChildScrollView(
      child: Container(
        height: iskeyboard ? 0 : 500,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text( widget.title  ,style:    Theme.of(context).textTheme.titleSmall! ,
            ),
            Container(
              child: TextField(
                controller: textEditingController,
                maxLines: 15,
                 decoration: InputDecoration(
                   hintText: widget.text2,
                   border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(5),
                     borderSide: BorderSide(
                       color: Colors.transparent,
                       width: 1,
                     ),

                   ),
                   enabledBorder: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(5),
                     borderSide: BorderSide(
                       color: Colors.transparent,
                       width: 1,
                     ),
                   ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                    ),
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
              , child: Text(  Translation().translate().Ok   ,style:  Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 20)!)
              ),
      
            )
      
      
          ],
      
        ),
      ),
    );

  }
}
