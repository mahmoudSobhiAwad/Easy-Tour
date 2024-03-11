import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/settings/presentaion/views/widgets/payment_setting_item.dart';

class ReviewToViewForTourist extends StatelessWidget {
  const ReviewToViewForTourist({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height*0.1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Reviews', style: CustomTextStyle.commonSignThinDark),
          const Expanded(child: SizedBox(height: 10,)),
          ProfileSettingItem(
            height: height * 0.07,
            rightWidget:const Text('30 (review)') ,
            child: const Icon(Icons.arrow_forward_ios,color: basicColor,),
          ),
        ],
      ),
    );
  }
}