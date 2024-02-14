import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/manager/view_trip_details_cubit/view_trip_details_state.dart';

class ViewTripDetailsCubit extends Cubit<ViewTripDetailsState>{
  ViewTripDetailsCubit():super(InitialViewTripDetailsState());
  int currentDay=0;
  ScrollController controller=ScrollController();
  void moveToNextDay(double width,){
    if(currentDay<9) {
      double offset = (currentDay + 1) * width;
      currentDay++;
      controller.animateTo(
        offset,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      emit(MoveToNextDayState());
    }

  }
  void moveToPrevDay(double width) {
    if(currentDay>0){
      double offset = (currentDay - 1) * width;
      currentDay--;
      controller.animateTo(
        offset,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      emit(MoveToPrevDayState());
    }
  }
}