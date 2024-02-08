import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/features/splash/presentation/views/widgets/on_boarding_body.dart';
import '../../manager/on_boarding_cubit.dart';

class PageViewBody extends StatelessWidget {
  const PageViewBody({super.key,  required this.cubit,});
  final OnBoardingCubit cubit;
  @override
  Widget build(BuildContext context) {
    final double height=BasicDimension.screenHeight(context);
    final double width=BasicDimension.screenWidth(context);
    return SizedBox(
      height: height,
      child: PageView.builder(
        controller: cubit.controller,
        itemCount: 3,
        onPageChanged: (index){
          cubit.onChangePage(index);
        },
        itemBuilder: (context,index)=> OnBoardingOne(cubit: cubit,height: height,width: width,),
      ),
    );
  }
}


