import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/tourist/google_map/data/models/text_search_model.dart';
class PlaceDetailsWithSearchText extends StatelessWidget {
  const PlaceDetailsWithSearchText({
    super.key,
    required this.height,
    required this.width,
    required this.model,
    this.onTap,
  });

  final double height;
  final double width;
  final TextSearchModel model;
  final void Function()?onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height*0.2,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft:Radius.circular(12) ,topRight: Radius.circular(12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(child: SizedBox(
              width: width*0.1,
              child: const Divider(color: entertainmentColor,height: 10,))),
          Text(model.displayName??""),
          Row(children: [
            Text('${model.rating??""}'),
            Row(
              children: [
                ...List.generate(5, (index) {
                  return index<(model.rating?.toInt()??3)?const Icon(Icons.star,color: Colors.amber,):const Icon(Icons.star_border_purple500_outlined,color: thirdColor,);
                }),
              ],)
          ],),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  width: width*0.6,
                  child: Text(model.address??"",style: CustomTextStyle.fontNormal14WithEllipsis,)),
              model.openNow! ?Text('open now',style: CustomTextStyle.font16Light.copyWith(color: whatsAppColor),):Text('Closed',style: CustomTextStyle.font16Light.copyWith(color: closeColor),),
            ],
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: width*0.33,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: forthColor,borderRadius: commonBorderRadius()),
              child: Row(
                children: [
                  Text('Direction',style: CustomTextStyle.fontNormal16.copyWith(color: Colors.white),),
                  const Icon(Icons.directions,color: Colors.white,)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}