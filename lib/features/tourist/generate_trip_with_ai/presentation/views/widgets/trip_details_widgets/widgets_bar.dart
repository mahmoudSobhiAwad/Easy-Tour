import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
class ChangeShowForWidgetInGeneratedTrip extends StatelessWidget {
  const ChangeShowForWidgetInGeneratedTrip({
    super.key,
    required this.changeShow,
    required this.height,
    required this.barName,
    required this.showDetails,
  });

  final void Function()? changeShow;
  final double height;
  final String barName;
  final bool showDetails;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:changeShow,
      child: Container(
        height:height*0.1,
        decoration: BoxDecoration(
          color: thirdColor,
          borderRadius: commonBorderRadius(),
        ),
        padding:const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(barName,style: CustomTextStyle.fontSecondaryBold22,),
            RotatedBox(
                quarterTurns:showDetails? 1:-1,
                child: const Icon(Icons.arrow_back_ios,)),
          ],
        ),
      ),
    );
  }
}