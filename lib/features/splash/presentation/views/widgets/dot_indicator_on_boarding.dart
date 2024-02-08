import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prepare_project/core/utilities/go_router/go_router.dart';
import 'package:prepare_project/features/splash/presentation/manager/on_boarding_cubit.dart';

import '../../../../../core/widget/on_boarding/dot_indictaor.dart';

class DotIndicatorOnBoarding extends StatelessWidget {
  const DotIndicatorOnBoarding({super.key, required this.currIndex,this.cubit,required this.width});
  final double width;
  final int currIndex;
final OnBoardingCubit? cubit;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width*0.5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...List.generate(3, (index) =>dotIndicator(context, index,currIndex),),
          const Expanded(child: SizedBox(width: 30,)),
          currIndex==2?InkWell(
              onTap: (){
                cubit?.dispose();
            context.go(RouterApp.kLoginView);

          },child: const CircleAvatar(radius: 27.5,backgroundColor: Color(0xff1F96B0),child:  Center(child: Icon(Icons.arrow_forward_ios,color: Colors.white,size: 27,)),)):const SizedBox(),

        ],
      ),
    );
  }
}