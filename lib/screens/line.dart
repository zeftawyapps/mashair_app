import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
class Line extends StatelessWidget {
  const Line({super.key});

  @override
  Widget build(BuildContext context) {
    return DottedLine(
      direction: Axis.horizontal,
      alignment: WrapAlignment.center,
      lineLength: double.infinity,
      lineThickness: 1.0,
      dashLength: 1.5,
      dashColor:  Theme.of(context).primaryColor,
     
     
      dashRadius: 10.0,
      dashGapLength: 2.0,
      dashGapColor:  Colors.transparent,
      dashGapRadius: 10.0,
    );
  }
}
