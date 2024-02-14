import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
class OneTripPerDayItem extends StatelessWidget {
  const OneTripPerDayItem({super.key,required this.height,required this.width});
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        height:height*0.2 ,
        width: width,
        decoration:BoxDecoration(
          color: Colors.white,
          borderRadius: commonBorderRadius(),
          boxShadow: [
            buildBoxShadow(),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                height: height*0.075,
                width: width*0.15,
                decoration: BoxDecoration(
                    color: thirdColor,shape: BoxShape.circle,boxShadow: [buildBoxShadow()]),
                child: const Icon(Icons.museum_rounded)),
            const SizedBox(width: 15,),
            SizedBox(
              width: width*0.5,
              height: height*0.15,
              child: ListView(
                padding: EdgeInsets.zero,
                children:const [
                  Text('Citadel of Salah-Elddin',style: CustomTextStyle.commonSignDark,),
                  Text('Discover the place there and enjoy with the atmosphere, Discover the place there and enjoy with the atmosphere,',style: CustomTextStyle.commonFontThin,),
                ],
              ),
            ),
            const SizedBox(width: 15,),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed:(){},tooltip: 'Location in google Map',icon:const Icon(Icons.location_on_rounded,color: basicColor,)),
                IconButton(onPressed:(){},tooltip: 'Discover Places Around',icon:const Icon(Icons.language,color: basicColor,)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}