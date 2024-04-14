import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/model/generated_trip_model.dart';
import 'package:prepare_project/features/tourist/settings/presentaion/views/widgets/payment_setting_item.dart';

class OneActivityInGeneratedTrip extends StatelessWidget {
  const OneActivityInGeneratedTrip({super.key,required this.height,required this.width,required this.place});
  final double height;
  final double width;
  final Place place;
  @override
  Widget build(BuildContext context) {
    const String imageUrl='https://upload.wikimedia.org/wikipedia/commons/0/0c/Cairo_pyramids%2C_Dec_2008_-_59.jpg';
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: thirdColor,width: 3),
        color: Colors.white,
        borderRadius: commonBorderRadius(),
        boxShadow: [buildBoxShadow()],
      ),
      padding: EdgeInsets.symmetric(horizontal:width*0.0125 ,vertical:height*0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
              borderRadius: commonBorderRadius(),
              child: Image.network(imageUrl,height: height*0.2,width: width*0.25,fit: BoxFit.fitHeight,)),
          SizedBox(
            width: width*0.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(place.name,style: CustomTextStyle.commonSignDark,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width*0.5,
                      child: Text(place.activity,
                        style: CustomTextStyle.commonFontThinLight,maxLines: 3,softWrap: true,),),
                    GestureDetector(onTap: null, child:const Text('See More',style: TextStyle(decoration: TextDecoration.underline),)),
                  ],
                ),
                 ProfileSettingItem(
                  enableDivider: false,
                  rightWidget: const Text('Place Price',style:CustomTextStyle.commonFontThin,),
                  child: Row(children: [
                    Text('${place.budget}',style: CustomTextStyle.commonFontThin,),
                    const Icon(Icons.airplane_ticket,color: basicColor,)
                  ],),),
                ProfileSettingItem(
                  enableDivider: false,
                  rightWidget: const Text('Time Visiting',style:CustomTextStyle.commonFontThin,),
                  child: Container(
                    width: width*0.35,
                    padding:const EdgeInsets.all(5),
                    decoration: BoxDecoration(color: thirdColor,borderRadius: BorderRadius.circular(10)),
                    child:  Text(place.time??"",style: CustomTextStyle.tripDetailsInTourGuide,),
                  ),),
              ],
            ),
          )
        ],
      ),
    );
  }
}