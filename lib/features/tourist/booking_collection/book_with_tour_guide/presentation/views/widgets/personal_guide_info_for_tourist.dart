import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tour_guide/profile/data/model/guide_personal_info_model.dart';
import 'package:prepare_project/features/tourist/settings/presentaion/views/widgets/payment_setting_item.dart';

class PersonalInfoOfTourToViewTourist extends StatelessWidget {
  const PersonalInfoOfTourToViewTourist({
    super.key,
    required this.height,
    required this.model,
  });

  final double height;
  final TourGuidePersonalInfoModel? model;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height*0.33,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          const Text('Personal Info',style: CustomTextStyle.fontNormal16),
          const Expanded(child:  SizedBox(height: 10,)),
          ProfileSettingItem(
            text: 'Languages',
            height: height*0.07,
            child: Text(
              '${model?.lang?.join(',')}',
              style:CustomTextStyle.fontNormal14WithEllipsis,),
          ),
          ProfileSettingItem(text: 'Phone Number',height: height*0.07,child:  Text('${model?.phoneNumber}',style:CustomTextStyle.fontNormal14WithEllipsis,),),
          ProfileSettingItem(text: 'Address',height: height*0.07,child:  Text('${model?.address}',style:CustomTextStyle.fontNormal14WithEllipsis ,)),
          ProfileSettingItem(text: 'Date Of Birth',height: height*0.07,child: Text('${model?.date}',style:CustomTextStyle.fontNormal14WithEllipsis ,)),
        ],
      ),
    );
  }
}