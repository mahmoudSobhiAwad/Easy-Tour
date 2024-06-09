import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
class TripHistoryItem extends StatelessWidget {
  const TripHistoryItem({super.key,required this.height,required this.width,this.behindTitle,required this.tripType,required this.tripTitle,required this.leftIcon});
  final double width;
  final double height;
  final String tripTitle;
  final String tripType;
  final Icon leftIcon;
  final Widget?behindTitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        width: width,
        height: height*0.12,
        decoration: BoxDecoration(
          color: thirdColor,
          borderRadius: commonBorderRadius(),
        ),
        padding: const EdgeInsets.all(7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: width*0.6,
                    child: Text(tripTitle,style: CustomTextStyle.fontNormal16,overflow: TextOverflow.ellipsis,)),
                behindTitle??const SizedBox(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                leftIcon,
                const Text('11 May 2024'),
                ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child:  ColoredBox(
                      color: secondaryColor,
                      child: Padding(
                        padding:const EdgeInsets.all(5.0),
                        child: Text('#$tripType'),
                      ),)),
                ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: const ColoredBox(
                      color: secondaryColor,
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text('10 Days'),
                      ),)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}