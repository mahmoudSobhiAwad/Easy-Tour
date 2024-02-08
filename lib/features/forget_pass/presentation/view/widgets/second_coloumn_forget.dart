import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/login_sign_up/otp_box.dart';

class SecondColumnResetPass extends StatelessWidget {
  const SecondColumnResetPass({super.key,required this.onPressed,required this.otpKey,required this.otpController,required this.height});
  final Key otpKey;
  final TextEditingController otpController;
  final double height;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        SizedBox(
            height:height*0.15,
            child:  OtpBox(otpKey: otpKey,otpController: otpController,)),
        const SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Don\'t receive Code?',style: CustomTextStyle.commonSignLight),
            TextButton(onPressed: onPressed, child:  const Text('Resend It',style: CustomTextStyle.commonSignDark)),
          ],),
      ],
    );
  }
}