import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/views/widgets/one_review_for_one_trip.dart';
class ShowReviewInTourGuideTrip extends StatelessWidget {
  const ShowReviewInTourGuideTrip({super.key,required this.height,required this.width});
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Reviews',style: CustomTextStyle.commonSignDark,),
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
                return ItemReviewForOneTrip(width: width, height: height);
              }
          ),
        ),
      ],
    );
  }
}

