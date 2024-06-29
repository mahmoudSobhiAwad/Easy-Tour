import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
class ChangeShowForWidgetInGeneratedTrip extends StatelessWidget {
  const ChangeShowForWidgetInGeneratedTrip({
    super.key,
    required this.height,
    required this.barName,
    required this.showDetails,
  });

  final double height;
  final String barName;
  final bool showDetails;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height:height*0.05,
        decoration: BoxDecoration(
          color: thirdColor,
          borderRadius: BorderRadius.circular(12),
        ),
        padding:const EdgeInsets.all(10),
        child: Row(
          children: [
            Text(barName,style: CustomTextStyle.fontBold16,),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}