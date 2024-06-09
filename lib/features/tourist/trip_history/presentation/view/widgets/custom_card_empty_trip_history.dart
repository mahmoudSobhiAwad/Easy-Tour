import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
class CustomCardInEmptyTripHistory extends StatelessWidget {
  const CustomCardInEmptyTripHistory({super.key,required this.width,required this.height,required this.text,required this.imagePath,required this.color});
  final Color color;
  final double width;
  final double height;
  final String text;
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: width*0.4,
      height: height*0.25,
      decoration: BoxDecoration(
        color: color,
        borderRadius: commonBorderRadius(),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(imagePath,width: width*0.3,height: height*0.15,fit: BoxFit.fitWidth,),
          Text(text,style: CustomTextStyle.fontNormal16.copyWith(color: whiteColor),textAlign: TextAlign.center,)
        ],
      ),
    );
  }
}