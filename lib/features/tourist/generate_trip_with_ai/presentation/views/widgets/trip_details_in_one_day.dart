import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/function/get_image_with_type.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/model/generated_trip_model.dart';
import 'package:prepare_project/features/tourist/nearby_places/presentation/views/widgets/pick_category_widget.dart';
class OneTripPerDayItem extends StatelessWidget {
  const OneTripPerDayItem({super.key,required this.height,required this.width,required this.placeItem});
  final double height;
  final double width;
  final Place placeItem;
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
            PickedCategoryItem(padding: EdgeInsets.zero,height: height*0.7, width: width*0.7, typeImage:getImageFromType(placeItem.category), picked: false),
            SizedBox(
              width: width*0.5,
              height: height*0.15,
              child: ListView(
                padding: EdgeInsets.zero,
                children:[
                  Text(placeItem.name,style: CustomTextStyle.commonSignDark,),
                  Text(placeItem.activity,style: CustomTextStyle.commonFontThinNoOverFlow,maxLines: 5,),
                ],
              ),
            ),
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
