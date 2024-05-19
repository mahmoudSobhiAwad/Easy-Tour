import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/tourist/tourist_feed/presentation/view/widgets/images_of_post_list.dart';
import 'package:prepare_project/features/tourist/tourist_feed/presentation/view/widgets/poster_info.dart';

class SocialItemPost extends StatelessWidget {
  final double width;
  final double height;
  const SocialItemPost({super.key,required this.height,required this.width});
  @override
  Widget build(BuildContext context) {
    int imagesLength=1;
    return Container(
      decoration: BoxDecoration(
        borderRadius: commonBorderRadius(),
        border: Border.all(color: secondaryColor,width: 2),
      ),
      padding:const EdgeInsets.all(12),
      child: Column(
        children: [
          PosterInfo(width: width),
          SizedBox(height: height*0.02,),
          const Text('it was a long day in pyramids with wonderful people, we talk about how the ancient Egyptian build that great pyramids.',),
          SizedBox(height: height*0.02,),
          ImagesOfPostList(imagesLength: imagesLength, height: height, width: width),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text('Send Message',style: CustomTextStyle.commonProfileDark,),
                  IconButton(onPressed: null, icon: Icon(Icons.send_rounded),),
                ],
              ),
              IconButton(onPressed: null, icon: Icon(Icons.bookmark_border)),
            ],
          )
        ],
      ),
    );
  }
}