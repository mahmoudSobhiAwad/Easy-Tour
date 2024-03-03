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
          SizedBox(height: height*0.03,child: Text('Egypt| ${model?.tripDetails?.length??0} days',style: CustomTextStyle.commonFontThin,)),
          SizedBox(height: height*0.08,child: Text('${model?.title}',maxLines: 2,style: CustomTextStyle.privateTourTitle,)),
          SizedBox(height: height*0.05,child: Text('${model?.brief}',maxLines: 2,style: CustomTextStyle.commonFontThin,)),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  width: width*0.4,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(borderRadius: commonBorderRadius(),color: secondaryColor),
                  child: Center(child: Text('$text ${model?.tripTicket?['standard']??'20'} \$ per person',style: CustomTextStyle.commonFontThin,maxLines: 2,textAlign: TextAlign.center,),),
                ),
              ),
              moreDet?TextButton(onPressed: null, child:Text('Tour Guide Profile',style: CustomTextStyle.commonSignDark.copyWith(decoration: TextDecoration.underline),),):
              Expanded(
                child: Container(
                  width: width*0.4,
                  height: height*0.05,
                  decoration: BoxDecoration(borderRadius: commonBorderRadius(),color: secondaryColor),
                  child: Center(child: Text('Maximum :${model?.maximumNumber} persons',style: CustomTextStyle.commonFontThin,),),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
