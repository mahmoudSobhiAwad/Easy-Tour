import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/change_passowrd/presentation/views/change_password_view.dart';
import 'package:prepare_project/features/tourist/settings/presentaion/views/widgets/custom_switch.dart';
import 'package:prepare_project/features/tourist/settings/presentaion/views/widgets/payment_setting_item.dart';
import 'package:prepare_project/features/tourist/settings/presentaion/views/widgets/setting_details_view.dart';

class ProfileSettingsPart extends StatelessWidget {
  const ProfileSettingsPart({
    super.key,
    required this.height,
    this.toggleAppMode,
    this.enableDarkMode=false,
    this.enableNotification=false,
    this.changeNotify,
    required this.width});

  final double height;
  final double width;
  final void Function()?toggleAppMode;
  final bool enableDarkMode;
  final void Function()?changeNotify;
  final bool enableNotification;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height*0.26,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Profile Settings',style:CustomTextStyle.fontNormal16),
          const Expanded(child:  SizedBox(height: 10,)),
          ProfileSettingItem(text: 'Change Password',onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return const SettingDetailsView(appBarTitle: 'Change Password', child:ChangePasswordView());
            }));
          },height: height*0.07,child:const Icon(Icons.arrow_forward_ios),),
          ProfileSettingItem(text: 'Send Push Notifications',onTap: changeNotify,height: height*0.07,child: CustomSwitch(active: enableNotification,width: width,height: height,),),
          ProfileSettingItem(text: 'dark Mode',onTap: toggleAppMode,height: height*0.07,child: CustomSwitch(active: enableDarkMode,width: width,height: height,),),
        ],
      ),
    );
  }
}

