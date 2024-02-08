import 'package:prepare_project/features/splash/presentation/manager/on_boarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:prepare_project/features/splash/presentation/views/widgets/blur_text_over_image.dart';
import 'package:prepare_project/features/splash/presentation/views/widgets/dot_indicator_on_boarding.dart';

import '../../../../../core/utilities/on_boarding/on_boarding_model.dart';
class OnBoardingOne extends StatelessWidget {
  const OnBoardingOne({super.key,this.cubit,required this.height,required this.width});
  final OnBoardingCubit ?cubit;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration:  BoxDecoration(image:DecorationImage(fit:BoxFit.fitHeight,image: AssetImage(onBoardList[cubit!.currIndex].imagePath),),),
          height:height ,
        ),
        BlurTextOverImage(cubit: cubit,height: height,width: width,),
        Positioned(
          bottom:height*0.1,
          left: width*0.4,
          child: DotIndicatorOnBoarding(currIndex:cubit!.currIndex,cubit: cubit,width: width,),),
      ],
    );
  }
}


