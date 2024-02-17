import 'package:flutter/animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/function/set_app_state.dart';
import 'package:prepare_project/features/tour_guide/home/data/repo/tour_guide_home_repo_imp.dart';
import 'package:prepare_project/features/tour_guide/home/presentation/manager/home_tour_guide_state.dart';

class TourGuideHomeCubit extends Cubit<TourGuideHomeStates>{
  TourGuideHomeCubit({required this.controller,required this.homeTourGuideRepoImp}):super(InitialTourGuideHomeState());
  int currIndex=0;
  bool isMenuActive=false;
  String touristName= SetAppState.prefs?.getString('name')??"";
  String? profileUrl= SetAppState.prefs?.getString('profileUrl');
  final HomeTourGuideRepoImp homeTourGuideRepoImp;
  final AnimationController? controller;
  void changeMenuState(){
    isMenuActive=!isMenuActive;
    emit(ChangeTourGuideHomeMenuState());
  }
  void openSideBar()async
  {
    changeMenuState();
    controller?.forward();
    emit(ChangeTourGuideHomeAnimationState());
  }
  void closeSideBar()
  {
    changeMenuState();
    controller?.reverse();
    emit(ChangeTourGuideHomeAnimationState());
  }
  Future<void> logOut()async{
    emit(LoadingLogOutTourGuideState());
    var result =await homeTourGuideRepoImp.logOut();
    result.fold(
            (failure){
              if(failure.statusCode==401){
                emit(RefreshTokenErrorState('error due to refresh token,please try again'));
              }
          emit(FailureLogOutTourGuideState(failure.errMessage));
        }, (logOut) async {
              await SetAppState.setToken(token: '');
              await SetAppState.setRole(role: '');
              await SetAppState.setProfilePic(profileUrl: '');
              emit(SuccessLogOutTourGuideState());
            }
    );

   }

}