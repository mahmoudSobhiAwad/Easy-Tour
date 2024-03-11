import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';

class ButtonInTourProfile extends StatelessWidget {
  const ButtonInTourProfile({
    super.key,
    required this.color,
    required this.text,
    required this.width,
    required this.height,
    this.onTap,
    this.icon,
  });
  final Color color;
  final String text;
  final double width;
  final double height;
  final void Function()?onTap;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        width: width*0.45,
        decoration: BoxDecoration(
          color: color,
          borderRadius: commonBorderRadius(),
          boxShadow: [buildBoxShadow()],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text,style: CustomTextStyle.commonFontThin.copyWith(color: Colors.white,fontSize: 15),),
            Transform.rotate(
              angle: -45,
              child: Icon(icon,color: Colors.white,),
            )
          ],
        ),
      ),
    );
  }
}