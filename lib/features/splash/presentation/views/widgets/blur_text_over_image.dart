import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/splash/presentation/manager/on_boarding_cubit.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utilities/on_boarding/on_boarding_model.dart';
class BlurTextOverImage extends StatelessWidget {
  const BlurTextOverImage({
    super.key,
    required this.cubit,
    required this.height,
    required this.width
  });

  final OnBoardingCubit? cubit;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: height*0.2,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2,sigmaY: 2),
        child: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: SizedBox(
              height:height*0.25,
              width:width*0.9,
              child:  AnimatedTextKit(
                  // totalRepeatCount: 3,
                  // isRepeatingAnimation: false,
                  animatedTexts: [
                    TyperAnimatedText(onBoardList[cubit!.currIndex].text,textStyle:CustomTextStyle.fontBold48,speed:const Duration(milliseconds: 70)),
                  ])),
              //child: Text(onBoardList[cubit!.currIndex].text,style: CustomTextStyle.onBoardingTitle,)),
        ),
      ),
    );
  }
}