import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prepare_project/core/utilities/go_router/go_router.dart';
import 'package:prepare_project/features/login/presentation/manager/login_cubit.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/do_not_have_acc.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_form.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/sign_in_options.dart';

class LoginOfTourism extends StatelessWidget {
  const LoginOfTourism({
    super.key,
    required this.cubit,
    required this.height,
    required this.width,
  });

  final LoginCubit cubit;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children:  [
        LoginForm(cubit: cubit,
          emailTextEditingController:cubit.toggleRoleIndex==0?cubit.emailController:cubit.emailTourGuideController,
          passwordTextEditingController: cubit.toggleRoleIndex==0?cubit.passController:cubit.passTourGuideController,
        ),
        const SizedBox(height: 10,),
        cubit.toggleRoleIndex==0?
        OrSignInWith(
          width: width,
          height: height,
          signInWithGoogle: ()async {
            await cubit.signInWithGoogle();
            },
        ):
        SizedBox(height:height*0.12,),
        DoNotHaveAcc(content: 'Don’t have an account ?',buttonText: 'Sign Up',onPressed: (){context.push(RouterApp.kSignUpView);},),
      ],
    );
  }
}