import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
class ShowReviewInTourGuideTrip extends StatelessWidget {
  const ShowReviewInTourGuideTrip({super.key,required this.height,required this.width});
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Reviews',style: CustomTextStyle.fontBold16,),
        Container(
          height: height*0.4,
          width: width,
          padding: EdgeInsets.symmetric(horizontal: width*0.025,vertical: height*0.02),
          decoration: BoxDecoration(
            color: thirdColor,
            borderRadius: commonBorderRadius(),
          ),
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: 5,
              itemBuilder: (context,index) {
                return const SizedBox();
               // return ItemReviewForOneTrip(width: width, height: height);
              }
          ),
        ),
      ],
    );
  }
}

