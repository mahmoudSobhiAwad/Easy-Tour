import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
class TripHistoryItem extends StatelessWidget {
  const TripHistoryItem({super.key,required this.height,this.tripDuration,required this.width,this.besideTitle,this.tripDate,required this.tripType,required this.tripTitle,required this.leftIcon});
  final double width;
  final double height;
  final String tripTitle;
  final String tripType;
  final int ?tripDuration;
  final Icon leftIcon;
  final Widget?besideTitle;
  final String?tripDate;
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
                    child: Text(tripTitle.toUpperCase(),style: CustomTextStyle.fontBold18,overflow: TextOverflow.ellipsis,)),
                besideTitle??const SizedBox(),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  leftIcon,
                  SizedBox(width: width*0.01,),
                  Text(tripDate??"UnKnown"),
                  SizedBox(width: width*0.01,),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child:  ColoredBox(
                        color: secondaryColor,
                        child: Padding(
                          padding:const EdgeInsets.all(5.0),
                          child: Text('#$tripType'),
                        ),)),
                  SizedBox(width: width*0.01,),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child:  ColoredBox(
                        color: secondaryColor,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('${tripDuration??"UnKnown"} Days'),
                        ),)),
                  SizedBox(width: width*0.01,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}