import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/constant_var/constant.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_page_view.dart';
import 'package:prepare_project/features/sign_up/presentation/manager/sign_up_cubit.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/first_column_sign_up.dart';
import 'package:prepare_project/core/widget/login_sign_up/progress_indicator_sign_up.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/second_column_sign_up.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/third_column_sign_up.dart';

class SignUpAsTourGuide extends StatelessWidget {
  const SignUpAsTourGuide({super.key,required this.cubit,required this.height});
  final SignUpCubit cubit;
  final double height;
  @override
  Widget build(BuildContext context) {
    final double width=BasicDimension.screenWidth(context);
    return  Padding(
      padding:EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.06,),
      child:   Column(
        children: [
          const SizedBox(height: 10,),
          CustomLinearProgressIndicator(stepsNames: stepsNamesSignUp,index: cubit.progressIndex,),
          const SizedBox(height: 15,),
          CustomPageViewLoginSignUp(
            scrollPhysics: const NeverScrollableScrollPhysics(),
            progressIndex: cubit.progressIndex,
            height: height*0.9,
            children: [
              FirstColumnOfSignUpTourGuide(cubit: cubit,height: height,),
              SecondColumnOfSignUpTourGuide(height: height,cubit: cubit,width: width,),
              ThirdColumnOfSignUpTourGuide(cubit: cubit,height: height,),],
          ),
        ],
      ),
    );
  }
}
