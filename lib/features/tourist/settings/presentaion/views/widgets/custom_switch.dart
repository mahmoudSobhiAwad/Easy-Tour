import 'package:flutter/material.dart';

import '../../../../../../core/utilities/basics.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({super.key,required this.active,required this.height,required this.width});
  final bool active;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return  Stack(
      alignment: active?Alignment.centerRight:Alignment.centerLeft,
      children: [
        Container(
          padding: EdgeInsets.zero,
          width: width*0.14,
          height: height*0.04,
          decoration: BoxDecoration(
            color: thirdColor.withOpacity(0.6),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: CircleAvatar(
            radius: 12,backgroundColor: active?basicColor:entertainmentColor.withOpacity(0.75),),
        ),
      ],
    );
  }
}