import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/features/splash/presentation/manager/on_boarding_states.dart';

import '../../../../core/utilities/function/set_app_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingStates>{
  OnBoardingCubit():super(InitialOnBoardingState());
  late PageController controller;
  int currIndex=0;
  void initOnBoarding(){
    controller=PageController(initialPage: 0);
    emit(SuccessOnBoardingState());
  }
  void dispose(){
    controller.dispose();
  }
  void onChangePage(int index)async {
    currIndex=index;
    await SetAppState.setCurrIndex(index);
    emit(ChangeOnBoardingIndexState());
  }
}