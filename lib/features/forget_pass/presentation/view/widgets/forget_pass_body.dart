import 'package:flutter/material.dart';
import 'package:prepare_project/features/forget_pass/presentation/manager/forget_pass_cubit.dart';
import 'package:prepare_project/features/forget_pass/presentation/view/widgets/forget_pass_tour_guide.dart';
import 'package:prepare_project/features/forget_pass/presentation/view/widgets/forget_tourist_pass.dart';
import '../../../../../core/utilities/basics.dart';
import '../../../../../core/utilities/constant_var/constant.dart';
import '../../../../../core/widget/login_sign_up/app_bar_sign_up.dart';
import '../../../../../core/widget/login_sign_up/progress_indicator_sign_up.dart';
import '../../../../login/presentation/view/widgets/login_button.dart';

class ForgetPasswordBody extends StatelessWidget {
  const ForgetPasswordBody({super.key,required this.cubit});
  final ForgetPassCubit cubit;
  @override
  Widget build(BuildContext context) {
    final double height=BasicDimension.screenHeight(context);
    final double width=BasicDimension.screenWidth(context);
    return  Padding(
      padding: EdgeInsets.only(left:width*0.05,right:width*0.05,top:height*0.07,bottom:MediaQuery.of(context).viewInsets.bottom+10 ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            CustomSignInUpBar(
              changeRole:(index){ cubit.changeToggleIndex(index);},
              height: height,
              width: width,
              toggleRoleIndex: cubit.toggleRoleIndex,
              progressIndex:cubit.role==Role.tourist? cubit.progressTouristIndex:cubit.progressTourGuideIndex,
              backwardProgressIndex:cubit.backwardProgressIndex,
            ),
            const SizedBox(height: 20,),
            CustomLinearProgressIndicator(stepsNames: stepsNamesResetPassword,index:cubit.role==Role.tourist? cubit.progressTouristIndex:cubit.progressTourGuideIndex,),
            SizedBox(
              height: height*0.5,
              child: cubit.toggleRoleIndex==0?ForgetPasswordTourist(height: height, cubit: cubit):ForgetPasswordTourGuide(height: height, cubit: cubit),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.2,),
            CustomLoginButton(
              isLoading: cubit.showLoading,
              label: loginResetPassword[cubit.role==Role.tourist? cubit.progressTouristIndex:cubit.progressTourGuideIndex],
              onTap:[
                    (){
                  cubit.forgetPasswordForBothRole();
                },
                    (){
                  cubit.checkOtp();
                }, (){
                  cubit.resetPasswordForBothRole();
                },
              ][cubit.role==Role.tourist? cubit.progressTouristIndex:cubit.progressTourGuideIndex],
            ),
          ],
        ),
      ),
    );
  }
}





