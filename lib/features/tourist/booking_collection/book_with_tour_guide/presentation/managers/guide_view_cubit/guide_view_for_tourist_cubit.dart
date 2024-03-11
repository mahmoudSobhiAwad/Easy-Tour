import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/features/tour_guide/profile/data/model/guide_personal_info_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/data/repo/get_guide_info_repo/get_guide_info_repo_imp.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/managers/guide_view_cubit/guide_view_for_tourist_state.dart';

class ViewGuideCubitForTourist extends Cubit<GuideViewForTouristState>{
  ViewGuideCubitForTourist({required this.getGuideInfoForTouristRepImp,required this.tourGuideEmail}):super(InitialGuideViewForTouristState());
  final GetGuideInfoForTouristRepImp getGuideInfoForTouristRepImp;
  bool isLoading=false;
  final String tourGuideEmail;
  TourGuidePersonalInfoModel? model;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  Future<void> getTourGuideData()async{
    isLoading=true;
    emit(LoadingGetGuideViewForTouristState());
    var result=await getGuideInfoForTouristRepImp.getTourGuideInfoForTouristToView({"email":tourGuideEmail});
    result.fold((failure) {
      log(failure.errMessage.toString());
      isLoading=false;
      emit(FailureGetGuideViewForTouristState(errMessage:failure.errMessage));
    }, (successModel) async {
      Future.delayed(const Duration(seconds: 1),()async{
        model=successModel;
      }).then((value){
        emit(SuccessGetGuideViewForTouristState());
        isLoading=false;
      });

    });
  }
}