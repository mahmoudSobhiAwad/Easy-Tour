import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/constant_var/constant.dart';
import 'package:prepare_project/core/utilities/go_router/go_router.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/do_not_have_acc.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/sign_in_options.dart';
import 'package:prepare_project/features/sign_up/presentation/manager/sign_up_cubit.dart';
import 'package:prepare_project/core/widget/login_sign_up/create_acc_title.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_sign_form.dart';

class SignUpAsTourism extends StatelessWidget {
  const SignUpAsTourism({super.key, required this.cubit,required this.height,required this.width});

  final SignUpCubit cubit;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleOfCreateAcc(mainText: 'Create Account',
          mainStyle:CustomTextStyle.signINTitle ,
          secondaryStyle: CustomTextStyle.commonSignLight.apply(fontFamily: 'grover',),
          secondaryText: 'Fill your information below or register with your social account',),
        const SizedBox(height: 10,),
        Expanded(
          child: Container(
            height: height*0.7,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: thirdColor,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
              boxShadow:  [
                 BoxShadow(blurRadius: 4,offset: Offset(0, 4))
              ]
            ),
            child: Column(
              children: [
                CustomSignUpForm(cubit: cubit,height: height,role: Role.tourist,),
                OrSignInWith(
                   width: width,
                   height: height,
                   signInWithGoogle: () async{
                  await cubit.signUpAsTourist();
                },),
                const SizedBox(height: 10,),
                DoNotHaveAcc(content: 'Already have an Account?',buttonText: 'Sign In',onPressed: (){
                  context.go(RouterApp.kLoginView);
                },),
              ],
            ),
          ),
        ),
      ],
    );
  }
}