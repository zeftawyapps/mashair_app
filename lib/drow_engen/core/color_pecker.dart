import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
 class ColorPecker extends StatefulWidget {
  const ColorPecker({super.key});

  @override
  State<ColorPecker> createState() => _ColorPeckerState();
}

class _ColorPeckerState extends State<ColorPecker> {

 Color currentColor = Colors.limeAccent;
  @override
  Widget build(BuildContext context) {

    return  Container(

      child:
    SingleChildScrollView(
      child: Column(
        children: [
          ColorPicker(
            pickerColor: currentColor,
            onColorChanged: changeColor,
            showLabel: true,
            pickerAreaHeightPercent: 0.8,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(currentColor);
            },
            child: Text('Got it' , style: TextStyle(fontSize: 20),
          )),
        ],
      ),
    ));
  }

  void changeColor(Color value) {
    setState(() => currentColor = value);
  }
}
