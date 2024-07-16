import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tour_guide/requested_trips/data/models/handle_request_model.dart';
import 'package:prepare_project/features/tour_guide/requested_trips/presentaions/view/widgets/request_details/custom_divider_in_request_details.dart';
import 'package:prepare_project/features/tourist/profile/presentation/views/widgets/pic_profile_widget.dart';
class PersonalInfoForTourist extends StatelessWidget {
  const PersonalInfoForTourist({
    super.key,
    required this.model,
    required this.height,
    required this.width,
  });

  final RequestedByModel model;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Personal Info',style: CustomTextStyle.fontBold16,),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: ProfilePicWidget(imageUrl:model.image??"", height: height*0.08,),
          title: Text(model.userName??"",style: CustomTextStyle.fontBold16),
          subtitle:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(model.countryName??"",style: CustomTextStyle.fontBold16),
                  const SizedBox(width: 5,),
                  Text(model.countryFlag??"",style: CustomTextStyle.fontBold16,),
                ],
              ),
              Text('${model.age} YO',style: CustomTextStyle.fontBold16),
            ],
          ) ,

        ),
        SizedBox(height: height*0.015,),
        DividerInRequestWidget(width: width),
        SizedBox(height: height*0.015,),
      ],
    );
  }
}