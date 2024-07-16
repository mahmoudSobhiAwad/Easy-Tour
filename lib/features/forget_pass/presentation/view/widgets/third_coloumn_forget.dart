import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/constant_var/constant.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/login_sign_up/confirm_password.dart';
import 'package:prepare_project/core/widget/login_sign_up/create_acc_title.dart';
import 'package:prepare_project/core/widget/login_sign_up/password_text_field.dart';
import 'package:prepare_project/features/forget_pass/presentation/manager/forget_pass_cubit.dart';

class ThirdColumnResetPass extends StatelessWidget {
  const ThirdColumnResetPass({super.key,required this.cubit});
  final ForgetPassCubit cubit;
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        const SizedBox(height: 10,),
        SizedBox(
          height: MediaQuery.of(context).size.height*0.2,
          child:  TitleOfCreateAcc(
            mainStyle:CustomTextStyle.fontBold30 ,
            secondaryStyle: CustomTextStyle.font16Light,
            textAlign: TextAlign.start,
            mainText: 'Reset Password ? ',
            secondaryText: 'Please make it easy to remember and contains symbols, capital, small  characters and numbers',
            align: CrossAxisAlignment.start,),
        ),
        PasswordTextFormField(enablePassword: cubit.showPass,
            passwordController:cubit.role==Role.tourist? cubit.passTouristController:cubit.passTourGuideController,
            changeShowing: cubit.changeShow),
        const  SizedBox(height: 30,),
        ConfirmPasswordTextFormField(showConfirmPassword: cubit.showConfirmPass,
          confirmPasswordTextEditingController: cubit.confirmPassController,
          changeConfirmShowing:cubit.changeConfirmShow ,
        ),
      ],);
  }
}