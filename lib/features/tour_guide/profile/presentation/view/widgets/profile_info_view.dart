import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/get_social_widget.dart';
import 'package:prepare_project/features/tour_guide/profile/presentation/manager/view_profile_cubit.dart';
import 'package:prepare_project/features/tour_guide/profile/presentation/view/widgets/contact_info_view.dart';
import 'package:prepare_project/features/tour_guide/profile/presentation/view/widgets/edit_profile_view.dart';
import 'package:prepare_project/features/tour_guide/profile/presentation/view/widgets/licence_button.dart';
import 'package:prepare_project/features/tourist/settings/presentaion/views/widgets/payment_setting_item.dart';

class TourGuideProfileInfo extends StatelessWidget {
  const TourGuideProfileInfo({
    super.key,
    required this.height,
    required this.cubit,
    required this.width,
  });
  final double width;
  final double height;
  final TourGuideProfileViewCubit cubit;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          SizedBox(
            height: height*0.33,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Text('Personal Info',style: CustomTextStyle.fontNormal16),
                const Expanded(child:  SizedBox(height: 10,)),
                ProfileSettingItem(text: 'Edit Profile', onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> EditTourGuideProfileView(model: cubit.tourGuidePersonalInfoModel,profileViewCubit: cubit,)));
                },height: height*0.07,child: const Icon(Icons.arrow_forward_ios),),

                ProfileSettingItem(
                    text: 'Languages',
                    height: height*0.07,
                    child:  Text(cubit.getLang(),
                      style:CustomTextStyle.fontNormal14WithEllipsis,)),
                ProfileSettingItem(text: 'Phone Number',height: height*0.07,child: Text(cubit.phoneNum,style:CustomTextStyle.fontNormal14WithEllipsis,),),
                ProfileSettingItem(text: 'Address',height: height*0.07,child: Text(cubit.address,style:CustomTextStyle.fontNormal14WithEllipsis ,)),
              ],
            ),
          ),
          LicenceButton(height: height, licenceNames: cubit.licenceNames,cvUrl: cubit.cvUrl, width: width),
          SizedBox(
            height: height*0.11,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Text('Contact Info',style: CustomTextStyle.fontNormal16),
                const Expanded(child:  SizedBox(height: 10,)),
                ProfileSettingItem (
                  rightWidget:  Row(
                  children: [
                    ...List.generate(cubit.socialLinks.keys.length, (index) => GestureDetector(
                      onTap: (){
                        cubit.openLauncherApp(
                          index
                      );},
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: getSocialIcon(cubit.socialLinks.keys.elementAt(index)),
                      ),
                    )
                    ),
                  ],
                ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ContactInfoView(socialLinks: cubit.socialLinks,width: width,height: height,profileViewCubit: cubit,)));
                  },
                  height: height*0.07,
                  child: const Icon(Icons.arrow_forward_ios),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


