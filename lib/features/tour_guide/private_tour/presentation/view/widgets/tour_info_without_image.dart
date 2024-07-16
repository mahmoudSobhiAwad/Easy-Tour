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
    this.moreDet=false,
    this.text='',
  });

  final double height;
  final double width;
  final Trip? model;
  final bool moreDet;
  final String?text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: height*0.03,child: Text('Egypt| ${model?.tripDetails?.length??0} days',style: CustomTextStyle.fontNormal14WithEllipsis.copyWith(color: basicColor),)),
          SizedBox(height: height*0.08,child: Text('${model?.title}',maxLines: 2,style: CustomTextStyle.fontBold21.copyWith(color: basicColor),)),
          SizedBox(height: height*0.05,child: Text('${model?.brief}',maxLines: 2,style: CustomTextStyle.fontNormal14WithEllipsis.copyWith(color: basicColor),)),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(borderRadius: commonBorderRadius(),color: secondaryColor),
                  child: Center(child: Text('$text ${model?.tripTicket?['standard']??'20'} \$ per person',style: CustomTextStyle.fontNormal14WithEllipsis.copyWith(color: basicColor),maxLines: 2,textAlign: TextAlign.center,),),
                ),
              ),
              const SizedBox(width: 5,),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(borderRadius: commonBorderRadius(),color: secondaryColor),
                  child: Center(child: Text('Maximum :${model?.maximumNumber} persons',style: CustomTextStyle.fontNormal14WithEllipsis.copyWith(color: basicColor),),),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
