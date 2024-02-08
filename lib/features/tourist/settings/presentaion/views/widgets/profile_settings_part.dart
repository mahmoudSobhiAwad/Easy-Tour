import 'package:flutter/material.dart';
import 'package:prepare_project/core/widget/change_passowrd/presentation/views/change_password_view.dart';
import 'package:prepare_project/features/tourist/settings/presentaion/views/widgets/custom_switch.dart';
import 'package:prepare_project/features/tourist/settings/presentaion/views/widgets/payment_setting_item.dart';
import 'package:prepare_project/features/tourist/settings/presentaion/views/widgets/setting_details_view.dart';
import '../../../../../../core/utilities/basics.dart';

class ProfileSettingsPart extends StatelessWidget {
  const ProfileSettingsPart({
    super.key,
    required this.height,});

  final double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height*0.26,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Profile Settings',style: TextStyle(color: basicColor,fontWeight: FontWeight.bold),),
          const Expanded(child:  SizedBox(height: 10,)),
          ProfileSettingItem(text: 'Change Password',onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return const SettingDetailsView(appBarTitle: 'Change Password', child:ChangePasswordView());
            }));
          },height: height*0.07,child:const Icon(Icons.arrow_forward_ios),),
          ProfileSettingItem(text: 'Send Push Notifications',onTap: null,height: height*0.07,child: const CustomSwitch(active: true),),
          ProfileSettingItem(text: 'dark Mode',onTap: null,height: height*0.07,child: const CustomSwitch(active: false),),
        ],
      ),
    );
  }
}

