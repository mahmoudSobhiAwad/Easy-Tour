import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/tour_guide/private_tour/data/data_ui.dart';
import 'package:prepare_project/features/tour_guide/private_tour/data/model/private_tour_model.dart';

class OneTripPerDayItem extends StatelessWidget {
  const OneTripPerDayItem({super.key,required this.height,this.editOrDeleteWidget,this.fullWidth=true,required this.width,required this.placeItem});
  final double height;
  final double width;
  final TripPlace? placeItem;
  final Widget? editOrDeleteWidget;
  final bool fullWidth;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        width: fullWidth?width*0.95:width*.785,
        padding: EdgeInsets.zero,
        decoration:BoxDecoration(
          border: Border.all(color: secondaryColor,width: 5),
          color: thirdColor,
          borderRadius: commonBorderRadius(),
          boxShadow: [
            buildBoxShadow(),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(placeItem?.typeImageUrl??defaultImage,fit: BoxFit.fill,height: height*0.12,width: width,)),
            ),
            SizedBox(
              height: height*0.1,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                children:[
                  Text(placeItem?.placeName??"",style: CustomTextStyle.commonSignDark,),
                  Text(placeItem?.activity??"",style: CustomTextStyle.commonFontThinLight,maxLines: 5,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
