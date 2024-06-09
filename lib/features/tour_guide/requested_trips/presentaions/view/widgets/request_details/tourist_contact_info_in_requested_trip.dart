import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tour_guide/requested_trips/data/models/handle_request_model.dart';
import 'package:prepare_project/features/tour_guide/requested_trips/presentaions/view/widgets/request_details/custom_divider_in_request_details.dart';
import '../../../../../../tourist/settings/presentaion/views/widgets/payment_setting_item.dart';
class TouristContactInfo extends StatelessWidget {
  const TouristContactInfo({
    super.key,
    required this.height,
    required this.model,
    required this.width,
  });

  final double height;
  final RequestedByModel model;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Contact Info',style: CustomTextStyle.fontBold16,),
        SizedBox(height: height*0.015,),
        Column(
          children: [
            ProfileSettingItem(
              enableDivider: false,
              rightWidget: const Row(
                children: [
                  Icon(Icons.email,color: entertainmentColor,),
                  Text('Email')
                ],
              ),
              child: Text(model.email??"",style: CustomTextStyle.fontNormal14WithEllipsis,),
            ),
            const SizedBox(height: 10,),
            ProfileSettingItem(
              enableDivider: false,
              rightWidget: const Row(
                children: [
                  Icon(Icons.phone,color: entertainmentColor,),
                  Text('Phone Number',style: CustomTextStyle.fontNormal14WithEllipsis,)
                ],
              ),
              child: Text('+20 ${model.phoneNum}'),
            ),
          ],
        ),
        SizedBox(height: height*0.015,),
        DividerInRequestWidget(width: width),
        SizedBox(height: height*0.015,),
      ],
    );
  }
}