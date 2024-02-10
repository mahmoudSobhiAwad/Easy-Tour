import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/features/sign_up/presentation/manager/sign_up_cubit.dart';
import 'package:prepare_project/core/widget/login_sign_up/app_bar_sign_up.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/sign_up_as_tour_guide.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/sign_up_as_tourism.dart';
class SignUpBody extends StatelessWidget {
   const SignUpBody({super.key,required this.cubit});
    final SignUpCubit cubit;
    @override
  Widget build(BuildContext context) {
      final double height=BasicDimension.screenHeight(context);
      final double width=BasicDimension.screenWidth(context);
    return Padding(
      padding: EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.bottom,top:height*0.06),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSignInUpBar(
              changeRole: (index){
                cubit.changeToggleIndex(index);
              },
              width: width,
              height: height,
              toggleRoleIndex: cubit.toggleRoleIndex,
              progressIndex: cubit.progressIndex,
              backwardProgressIndex: cubit.backwardProgressIndex,
            ),
            SizedBox(height:height*0.03,),
            SizedBox(
              height: height*0.86,
              child: cubit.toggleRoleIndex==0?SignUpAsTourism(cubit: cubit,height: height,width: width,):SignUpAsTourGuide(cubit: cubit,height: height*0.84,),
            ),
          ],
        ),
      ),
    );
  }
}