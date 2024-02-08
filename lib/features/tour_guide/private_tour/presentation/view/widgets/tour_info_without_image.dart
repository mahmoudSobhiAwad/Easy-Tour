import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/tour_guide/private_tour/data/model/private_tour_model.dart';

class PrivateTourWithoutImage extends StatelessWidget {
  const PrivateTourWithoutImage({
    super.key,
    required this.height,
    required this.width,
    required this.model,
  });

  final double height;
  final double width;
  final Trip model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: height*0.03,child: const Text('Egypt 11 days',style: CustomTextStyle.commonFontThin,)),
          SizedBox(height: height*0.08,child: Text('${model.title}',maxLines: 2,style: CustomTextStyle.privateTourTitle,)),
          SizedBox(height: height*0.05,child: Text('${model.brief}',maxLines: 2,style: CustomTextStyle.commonFontThin,)),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: width*0.4,
                height: height*0.05,
                decoration: BoxDecoration(borderRadius: commonBorderRadius(),color: secondaryColor),
                child: Center(child: Text('minimum :${model.minimumNumber} persons',style: CustomTextStyle.commonFontThin,),),
              ),
              Container(
                width: width*0.4,
                height: height*0.05,
                decoration: BoxDecoration(borderRadius: commonBorderRadius(),color: secondaryColor),
                child: Center(child: Text('${model.ticketPerPerson} \$ per person',style: CustomTextStyle.commonFontThin,),),
              ),
            ],
          ),
        ],
      ),
    );
  }
}