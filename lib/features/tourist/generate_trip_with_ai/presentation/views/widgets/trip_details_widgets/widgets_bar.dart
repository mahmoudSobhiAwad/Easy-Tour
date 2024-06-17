import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
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
        height:height*0.1,
        decoration: BoxDecoration(
          color: thirdColor,
          borderRadius: commonBorderRadius(),
        ),
        padding:const EdgeInsets.all(10),
        child: Row(
          children: [
            Text(barName,style: CustomTextStyle.fontBold21.copyWith(fontSize: 25),),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}