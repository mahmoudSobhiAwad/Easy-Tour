import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prepare_project/core/utilities/go_router/go_router.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';

import '../../../../../core/widget/login_sign_up/create_acc_title.dart';
import '../../../../../core/widget/login_sign_up/email_text_form.dart';

class FirstColumnResetPass extends StatelessWidget {
  const FirstColumnResetPass({super.key,required this.controller,required this.height});
  final double height;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        const  SizedBox(height: 10,),
        SizedBox(
          height: height*0.2,
          child:const  TitleOfCreateAcc(
            mainStyle:CustomTextStyle.resetPassTitle ,
            secondaryStyle: CustomTextStyle.commonSignDark,
            textAlign: TextAlign.start,
            mainText: 'Forget password ? ',
            secondaryText: 'don’t worry it happens.\nplease enter your email associated to that account',
            align: CrossAxisAlignment.start,
          ),
        ),
        EmailTextFormField(emailTextEditingController: controller, ),
        const  SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Remembered Password?',style: CustomTextStyle.commonSignLight,),
            TextButton(onPressed: (){
              context.go(RouterApp.kLoginView);
            }, child: const Text('Sign In',style: CustomTextStyle.commonSignDark)),
          ],)
      ],);
  }
}
