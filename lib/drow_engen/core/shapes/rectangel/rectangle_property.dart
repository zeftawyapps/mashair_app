import 'package:flutter/material.dart';
class RectangleProperty extends StatefulWidget  implements Widget {
  const RectangleProperty({super.key});

  @override
  State<RectangleProperty> createState() => _RectanglePropertyState();
}

class _RectanglePropertyState extends State<RectangleProperty> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Wrap(
        children: [
          Text('Property'),
          SizedBox(
            height: 10,
          ),
          MaterialButton(
            onPressed: () {},
            child: Text('rectangle'),
          ),
        ],
      )
    );
  }
}
