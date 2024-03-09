import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/constant_var/constant.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
import 'package:prepare_project/features/sign_up/presentation/manager/sign_up_cubit.dart';
import 'package:prepare_project/core/widget/login_sign_up/confirm_password.dart';
import 'package:prepare_project/core/widget/login_sign_up/email_text_form.dart';
import 'package:prepare_project/core/widget/login_sign_up/password_text_field.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/name_text_form.dart';

class CustomSignUpForm extends StatelessWidget {
  const CustomSignUpForm({
    super.key,
    required this.cubit,
    required this.height,
    required this.role,
  });
  final SignUpCubit cubit;
  final double height;
  final Role role;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height*0.45,
      child: Column(
        children: [
          EmailTextFormField(emailTextEditingController: cubit.emailTextEditingController,),
          const SizedBox(height: 15,),
          cubit.toggleRoleIndex==0? Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: NameTextFormField(nameController: cubit.nameTextEditingController),
          ):
          const SizedBox(height: 0,),
          PasswordTextFormField(
            passwordController:cubit.passwordTextEditingController ,
            changeShowing: cubit.changeShowing,
            enablePassword: cubit.showPassword,
          ),
          const SizedBox(height: 15,),
          ConfirmPasswordTextFormField(
            borderColor: cubit.borderConfirmColor,
            onChangeConfirm:(String?value){ cubit.changeConfirmBorder();},
            changeConfirmShowing: cubit.changeConfirmShowing,
            showConfirmPassword: cubit.showConfirmPassword,
            confirmPasswordTextEditingController:cubit.confirmPasswordTextEditingController ,),
          const Expanded(child:  SizedBox(height: 15,)),
          CustomLoginButton(
            isLoading: cubit.showLoading,
              label: 'Sign Up',
              onTap:(){
                cubit.submitForm(role:role);
              }
          ),
        ],
      ),
    );
  }
}

