import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
class StartOrEndDate extends StatelessWidget {
  const StartOrEndDate({
    super.key,
    required this.width,
    required this.height,
    required this.text,
  });

  final double width;
  final double height;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width*0.35,
        height: height*0.07,
        child: Container(
          decoration: BoxDecoration(
            color: thirdColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: secondaryColor,width: 2),
          ),
          padding: const EdgeInsets.all(7),
          child:Center(child:  Text(text,textAlign: TextAlign.center,)),
        ));
  }
}
