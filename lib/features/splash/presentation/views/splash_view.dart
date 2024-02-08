import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/features/splash/presentation/manager/on_boarding_cubit.dart';
import 'package:prepare_project/features/splash/presentation/manager/on_boarding_states.dart';
import 'package:prepare_project/features/splash/presentation/views/widgets/page_view_body.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});
  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<OnBoardingCubit,OnBoardingStates>(
      builder: (context,state){
        var cubit=BlocProvider.of<OnBoardingCubit>(context);
        return Scaffold(
          body: PageViewBody(cubit: cubit,),
        );
      },

    );
  }
}








