import 'package:flutter/material.dart';
import 'package:prepare_project/core/widget/change_passowrd/presentation/manager/change_password_cubit.dart';
import 'package:prepare_project/core/widget/login_sign_up/confirm_password.dart';
import '../../../../../../core/utilities/basics.dart';
import '../../../../../../core/widget/login_sign_up/password_text_field.dart';

class ConfirmNewPassword extends StatelessWidget {
  const ConfirmNewPassword({
    super.key,
    required this.height,
    required this.cubit,
  });

  final double height;
  final ChangePasswordCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height*0.35,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Enter the new Password',style: TextStyle(color: basicColor),),
          const Text('Please make it easy to remember and contains capital, small  characters and numbers',style: TextStyle(color: secondaryColor),),
          PasswordTextFormField(
              height: height*0.11,
              enablePassword: cubit.newPassVis,
              passwordController: cubit.newPasswordController,
              changeShowing:(){ cubit.changeNewVisibility();}),
          ConfirmPasswordTextFormField(
            height: height*0.11,
            showConfirmPassword: cubit.confirmNewPassVis,
            changeConfirmShowing:(){ cubit.changeNewConfirmVisibility();},
            confirmPasswordTextEditingController:cubit.newConfirmPasswordController,),
        ],
      ),
    );
  }
}