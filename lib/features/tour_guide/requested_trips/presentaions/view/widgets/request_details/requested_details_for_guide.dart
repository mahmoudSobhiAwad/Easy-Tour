import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tour_guide/requested_trips/data/models/handle_request_model.dart';
import 'package:prepare_project/features/tour_guide/requested_trips/presentaions/view/widgets/request_details/custom_divider_in_request_details.dart';
import 'package:prepare_project/features/tourist/settings/presentaion/views/widgets/payment_setting_item.dart';
class RequestedDetails extends StatelessWidget {
  const RequestedDetails({
    super.key,
    required this.height,
    required this.model,
    required this.width,
  });

  final double height;
  final RequestedTripDetailsModel model;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Details Of Request',style: CustomTextStyle.commonSignDark,),
        SizedBox(height: height*0.015,),
        Column(
          children: [
            ProfileSettingItem(enableDivider: false,rightWidget: const Text('Start Trip Date',style: CustomTextStyle.commonFontThinLight,),child: Text(model.startDate??""),),
            const SizedBox(height: 10,),
            ProfileSettingItem(enableDivider: false,rightWidget: const Text('Trip Type ',style: CustomTextStyle.commonFontThinLight,),child: Text(model.tripType??""),),
            const SizedBox(height: 10,),
            ProfileSettingItem(enableDivider: false,rightWidget:const Text('Traveler With Tourist',style: CustomTextStyle.commonFontThinLight,),child: Text('${model.additionalTravelers}'),),
          ],
        ),
        SizedBox(height: height*0.015,),
        DividerInRequestWidget(width: width),
        SizedBox(height: height*0.015,),
      ],
    );
  }
}