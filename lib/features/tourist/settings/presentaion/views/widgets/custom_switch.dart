import 'package:flutter/material.dart';

import '../../../../../../core/utilities/basics.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({super.key,required this.active});
  final bool active;
  @override
  Widget build(BuildContext context) {
    return  Stack(
      alignment: active?Alignment.centerRight:Alignment.centerLeft,
      children: [
        Container(
          padding: EdgeInsets.zero,
          width: 48,
          height: 28,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: CircleAvatar(
            radius: 12,backgroundColor: active?basicColor:thirdColor,),
        ),
      ],
    );
  }
}