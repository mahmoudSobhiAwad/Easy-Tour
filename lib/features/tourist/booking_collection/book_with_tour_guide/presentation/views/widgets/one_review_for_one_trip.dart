import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/tourist/nearby_places/data/models/review_model.dart';
import 'package:prepare_project/features/tourist/profile/presentation/views/widgets/pic_profile_widget.dart';
class ItemReviewForOneTrip extends StatelessWidget {
  const ItemReviewForOneTrip({
    super.key,
    required this.width,
    required this.height,
    required this.model,
  });

  final ReviewModel model;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: width*0.025,vertical: height*0.01),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: thirdColor,width: 3),
          borderRadius: commonBorderRadius(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width:width*0.25,
                child: ProfilePicWidget(imageUrl: model.reviewerInfo?.photoUrl??"", height: height*0.1)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(model.reviewerInfo?.name??"",style: CustomTextStyle.commonSignDark.copyWith(overflow: TextOverflow.ellipsis),),
                    Text(model.reviewerInfo?.publishTime??"",style: CustomTextStyle.commonFontThinLight,),
                  ],),
                SizedBox(
                    width: width*0.6,
                    child: Text(model.reviewText??"",style: CustomTextStyle.commonFontThinNoOverFlow,)),
                Row(
                  children: [
                    ...List.generate(5, (index) {
                      return index<(model.rating??4)?const Icon(Icons.star,color: Colors.amber,):const Icon(Icons.star_border_purple500_outlined,color: thirdColor,);
                    }),
                  ],)
              ],
            )
          ],
        ),
      ),
    );
  }
}