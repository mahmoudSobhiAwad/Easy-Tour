import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/features/tour_guide/private_tour/data/model/private_tour_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/data/repo/get_all_tour_guide_trips_repo_imp.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/managers/tour_guide_trips_to_view_states.dart';

class TripsToViewCubit extends Cubit<TripsToViewStates>{
  TripsToViewCubit({this.tourGuideTripsForTouristRepoImp}):super(InitialTripsToViewState());
  final TourGuideTripsForTouristRepoImp? tourGuideTripsForTouristRepoImp;
  bool isLoading=false;
  List<Trip>tripList=[];
  int currDay=0;
  Future<void> getAllTrips()async{
    isLoading=true;
    emit(LoadingGetAllTripsToViewState());
    var result=await tourGuideTripsForTouristRepoImp?.getAllTourGuideTrips();
    result?.fold((failure) {
      if(failure.statusCode==401){
        getAllTrips();
      }
      else{
      emit(FailureGetAllTripsToViewState(errMessage: failure.errMessage));
      log(failure.errMessage.toString());
      isLoading=false;
      }
    }, (trips) {
      tripList.addAll(trips);

      emit(SuccessGetAllTripsToViewState());
       isLoading=false;
    });
  }
  void goToSelectedDay(int index){
    currDay=index;
    emit(MoveToSelectedDayInTrips());
  }
}