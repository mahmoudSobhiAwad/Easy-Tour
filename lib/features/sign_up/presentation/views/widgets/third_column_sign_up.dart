import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/constant_var/constant.dart';
import 'package:prepare_project/features/sign_up/presentation/manager/sign_up_cubit.dart';
import 'package:prepare_project/core/widget/sign_up_edit/custom_profile_pic.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_sign_form.dart';

class ThirdColumnOfSignUpTourGuide extends StatelessWidget {
  const ThirdColumnOfSignUpTourGuide({super.key,required this.cubit,required this.height});
  final SignUpCubit cubit;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomProfilePic(cubit: cubit,height: height,),
        const SizedBox(height: 30,),
        Container(
          height: height*0.62,
          padding: const EdgeInsets.all(20),
            decoration:const BoxDecoration(
              color: thirdColor,
              borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
            ),
            child: CustomSignUpForm(cubit: cubit,height: height,role: Role.tourGuide,)),
      ],
    );
  }
}