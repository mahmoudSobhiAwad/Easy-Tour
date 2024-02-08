import 'package:flutter/material.dart';
import 'package:prepare_project/core/widget/login_sign_up/email_text_form.dart';
import 'package:prepare_project/features/forget_pass/presentation/view/widgets/forget_pass_button.dart';
import 'package:prepare_project/features/login/presentation/manager/login_cubit.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
import 'package:prepare_project/core/widget/login_sign_up/password_text_field.dart';

class LoginForm extends StatelessWidget {
 const LoginForm({super.key,required this.cubit,required this.emailTextEditingController,required this.passwordTextEditingController});
 final LoginCubit cubit;
 final TextEditingController? emailTextEditingController;
 final TextEditingController? passwordTextEditingController;
@override
Widget build(BuildContext context) {
  return Column(
    children: [
      EmailTextFormField(emailTextEditingController:emailTextEditingController,
        emailFocusNode: cubit.emailFocusNode,passFocusNode: cubit.passFocusNode,),
      const SizedBox(height: 20,),
      PasswordTextFormField(
        passFocusNode: cubit.passFocusNode,
        enablePassword: cubit.showPass,
        passwordController: passwordTextEditingController,
        changeShowing: ()
        {
        cubit.changeShow();
        },),
      const SizedBox(height: 20,),
      CustomLoginButton(
        isLoading: cubit.showLoading,
        label: 'Login',
        onTap: ()async{
        cubit.completeLogin();
      },),
      const SizedBox(height: 10,),
     const ForgetPasswordButton(),
    ],);
}
}





