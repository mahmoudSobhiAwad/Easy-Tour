import 'dart:developer';
import 'package:flutter/animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/constant_var/constant.dart';
import 'package:prepare_project/core/utilities/function/set_app_state.dart';
import 'package:prepare_project/features/tour_guide/home/data/repo/tour_guide_home_repo_imp.dart';
import 'package:prepare_project/features/tour_guide/home/presentation/manager/home_tour_guide_state.dart';
import 'package:prepare_project/features/tourist/chat_with_other/data/models/recent_chat_model.dart';
import 'package:prepare_project/features/tourist/chat_with_other/data/repos/get_guide_meta_data/get_guide_meta_data_repo_imp.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class TourGuideHomeCubit extends Cubit<TourGuideHomeStates>{
  bool isLoadingRecentChats=false;
  TourGuideHomeCubit({required this.controller,required this.homeTourGuideRepoImp,required this.guideMetaDataRepoImp}):super(InitialTourGuideHomeState());
  int currIndex=0;
  bool isMenuActive=false;
  late io.Socket socket ;
  String touristName= SetAppState.prefs?.getString('name')??"";
  String profileUrl= SetAppState.prefs?.getString('profileUrl')??"";
  final String sourceEmail=SetAppState.prefs?.getString('email')??"";
  final HomeTourGuideRepoImp homeTourGuideRepoImp;
  final AnimationController? controller;
  final GuideMetaDataAndChatRecentRepoImp guideMetaDataRepoImp;
  List<RecentChatModel> chatsList=[];
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
            (failure) async {
              if(failure.statusCode==401)
              {
                logOut();
              }
             else if(failure.statusCode==500){
                await SetAppState.setToken(token: '');
                await SetAppState.setRole(role: '');
                await SetAppState.setProfilePic(profileUrl: '');
                emit(SuccessLogOutTourGuideState());
              }
              else{
                emit(FailureLogOutTourGuideState(failure.errMessage));
              }
        }, (logOut) async {
              await SetAppState.setToken(token: '');
              await SetAppState.setRole(role: '');
              await SetAppState.setProfilePic(profileUrl: '');
              emit(SuccessLogOutTourGuideState());
            }
    );

   }
  void connect() {
    socket = io.io(baseUrl,
        OptionBuilder()
            .setTransports(['websocket'])// for Flutter or Dart VM
            .disableAutoConnect()  // disable auto-connection
            .setExtraHeaders({'email': sourceEmail}) // optional
            .build()
    );
    socket.connect();
    socket.onConnect((data) {
      log('connected Success');
      socket.on("receiveMessage", (data) {
        log('Listening Now To Socket');
      });
    });
    socket.onDisconnect((_) => log('disconnect'));
  }
  void getRecentChats()async
  {
    isLoadingRecentChats=true;
    emit(LoadingGetRecentChatForTourGuideState());
    var result=await guideMetaDataRepoImp.getRecentChatList();
    result.fold(
            (failure){
          isLoadingRecentChats=false;
          emit(FailureGetRecentChatForTourGuideState(errMessage: failure.errMessage));
        },
            (chats){
          chatsList.addAll(chats);
          emit(SuccessGetRecentChatForTourGuideState());
          isLoadingRecentChats=false;
        }
    );
  }
}