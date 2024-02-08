import 'package:flutter/material.dart';
import 'package:prepare_project/features/login/presentation/manager/login_cubit.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/button_swap_role_signed_in.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_form.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/role_sign_in_pic.dart';

class LoginOfTourGuide extends StatelessWidget {
  const LoginOfTourGuide({
    super.key,
    required this.cubit,
    required this.height,
    required this.width
  });

  final LoginCubit cubit;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Column(
      children:  [
        RoleSignInPic(toggleRole: cubit.toggleRoleIndex,height: height,width: width,),
        const SizedBox(height: 10,),
        SwapButtonRole(
          height: height,
          changToggle: (index){
            cubit.changeToggleIndex(index);
          },
          width: width,
          toggleRoleIndex: cubit.toggleRoleIndex,
        ),
        const SizedBox(height: 25,),
        LoginForm(cubit: cubit,
          emailTextEditingController:cubit.emailTourGuideController,
          passwordTextEditingController:cubit.passTourGuideController,),
        SizedBox(height:height*0.12,),
      ],
    );
  }
}