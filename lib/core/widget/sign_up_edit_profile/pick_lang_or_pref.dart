import 'package:flutter/material.dart';

import '../../utilities/basics.dart';

class PickPreference extends StatelessWidget {
  const PickPreference({super.key,required this.height,required this.width,this.onTap,required this.titleOfButton});
  final double height;
  final double width;
  final void Function()?onTap;
  final String titleOfButton;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height:height*0.06,
        width: width,
        decoration: BoxDecoration(
          color: thirdColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(titleOfButton,style: const TextStyle(color: basicColor),),
            const Icon(Icons.arrow_drop_down,color: Colors.white,)
          ],
        ),
      ),
    );
  }
}