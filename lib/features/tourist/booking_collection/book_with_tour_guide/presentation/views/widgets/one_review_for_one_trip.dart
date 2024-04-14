import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/tourist/profile/presentation/views/widgets/pic_profile_widget.dart';
class ItemReviewForOneTrip extends StatelessWidget {
  const ItemReviewForOneTrip({
    super.key,
    required this.width,
    required this.height,
  });

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
          //boxShadow: [buildBoxShadow()],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width:width*0.25,
                child: ProfilePicWidget(imageUrl: '', height: height*0.1)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width:width*0.6,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Name',style: CustomTextStyle.commonSignDark,),
                      Text('Date',style: CustomTextStyle.commonFontThinLight,),
                    ],),
                ),
                SizedBox(
                    width: width*0.6,
                    child: const Text('Amira was extremely courteous and professional. She always responded to my generally,Amira was extremely courteous and professional. ',style: CustomTextStyle.commonFontThinNoOverFlow,)),
                Row(
                  children: [
                    ...List.generate(5, (index) {
                      return index<4?const Icon(Icons.star,color: Colors.amber,):const Icon(Icons.star_border_purple500_outlined,color: thirdColor,);
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