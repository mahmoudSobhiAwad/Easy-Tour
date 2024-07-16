import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/login_sign_up/create_acc_title.dart';
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
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          height: height*0.1,
          child:TitleOfCreateAcc(
            mainStyle:CustomTextStyle.fontBold30 ,
            secondaryStyle: CustomTextStyle.fontBold16,
            textAlign: TextAlign.start,
            mainText: 'Check Mail Box ! ',
            secondaryText: 'Code Consist of 6 chars write it carefully',
            align: CrossAxisAlignment.start,
          ),
        ),
        SizedBox(
            height:height*0.17,
            child:  OtpBox(otpKey: otpKey,otpController: otpController,)),
        GestureDetector(
          onTap: (){
          otpController.clear();
        },child: Text('clear ',style: CustomTextStyle.fontNormal16,),),
        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Text('Don\'t receive Code?',style: CustomTextStyle.font16Light),
            TextButton(onPressed: onPressed, child:  Text('Resend It',style: CustomTextStyle.fontBold16)),
          ],),
      ],
    );
  }
}