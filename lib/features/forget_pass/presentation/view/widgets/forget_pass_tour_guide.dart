import 'package:flutter/material.dart';
import 'package:prepare_project/features/forget_pass/presentation/view/widgets/first_coloumn_forget.dart';
import 'package:prepare_project/features/forget_pass/presentation/view/widgets/second_coloumn_forget.dart';
import 'package:prepare_project/features/forget_pass/presentation/view/widgets/third_coloumn_forget.dart';

import '../../../../../core/widget/login_sign_up/custom_page_view.dart';
import '../../manager/forget_pass_cubit.dart';

class ForgetPasswordTourGuide extends StatelessWidget {
  const ForgetPasswordTourGuide({
    super.key,
    required this.height,
    required this.cubit,
  });

  final double height;
  final ForgetPassCubit cubit;

  @override
  Widget build(BuildContext context) {
    return CustomPageViewLoginSignUp(
        scrollPhysics:const NeverScrollableScrollPhysics(),
        progressIndex: cubit.progressTourGuideIndex,
        children: [
          FirstColumnResetPass(controller: cubit.emailTourGuideController,height: height,),
          SecondColumnResetPass(otpKey: cubit.otpKey,otpController: cubit.otpController,height: height,onPressed: (){
            cubit.forgetTourGuidePassword();
          },),
          ThirdColumnResetPass(cubit: cubit,),
        ]);
  }
}
