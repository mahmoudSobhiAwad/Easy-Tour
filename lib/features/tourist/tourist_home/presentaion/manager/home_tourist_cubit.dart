import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:prepare_project/core/utilities/constant_var/constant.dart';
import 'package:prepare_project/features/tourist/tourist_home/data/repo/home_tourist_repo_impl.dart';
import 'package:prepare_project/features/tourist/tourist_home/presentaion/manager/home_tourist_state.dart';
//import 'package:socket_io_client/socket_io_client.dart';

import '../../../../../core/utilities/function/set_app_state.dart';
//import 'package:socket_io_client/socket_io_client.dart' as io;

class HomeTouristCubit extends Cubit<HomeTouristState>{
  HomeTouristCubit({required this.controller,required this.homeTouristRepoImp}):super(InitialHomeTouristState());
  bool isMenuActive=false;
  final AnimationController? controller;
  final String?touristName= SetAppState.prefs?.getString('name');
  String profileUrl= SetAppState.prefs?.getString('profileUrl')??'';
  final HomeTouristRepoImp homeTouristRepoImp;
  int currIndex=0;
  // late io.Socket socket ;
  Future<void>getProfilePicture()async{
    profileUrl= SetAppState.prefs?.getString('profileUrl')??'';
  }
  void changeMenuState(){
    isMenuActive=!isMenuActive;
    emit(ChangeHomeTouristMenuState());
  }
  void openSideBar()async
  {
    if(currIndex==0){
    changeMenuState();
    controller?.forward();
    emit(ChangeHomeTouristAnimationState());
    }
  }
  // void connect()
  // {
  //   socket = io.io(baseUrl,
  //       OptionBuilder()
  //           .setTransports(['websocket'])// for Flutter or Dart VM
  //           .disableAutoConnect()  // disable auto-connection
  //           .setExtraHeaders({'email': 'fdsfds'}) // optional
  //           .build()
  //   );
  //   socket.connect();
  //   // socket.emit('signing',sourceEmail);
  //   socket.onConnect((data) {
  //     debugPrint('connected Success');
  //     socket.on("message", (data) {
  //       // streamSocket.addResponse;
  //       debugPrint(data);
  //       debugPrint('working');
  //     });
  //   });
  //
  //   socket.onDisconnect((_) => debugPrint('disconnect'));
  //
  // }
  void closeSideBar()
  {
    if(currIndex==0){
    changeMenuState();
    controller?.reverse();
    emit(ChangeHomeTouristAnimationState());
    }
  }
  void changeBottomNavIndex(int index) {
    if(index!=currIndex)
    {
      currIndex=index;
    }
    emit(ChangeHomeTouristNavBottomState());
  }
  Future<void> logOut()async{
    emit(LoadingLogOutState());
    var result =await homeTouristRepoImp.logOut();
    result.fold(
        (failure){
          if(failure.statusCode==401)
          {
            emit(RefreshTokenErrorState('error due to refresh token try again'));
          }
          else{
          emit(FailureLogOutState(failure.errMessage));
          }
        }, (logOut) async {
          await SetAppState.setToken(token: '');
          await SetAppState.setRole(role: '');
          await SetAppState.setEmail(email: '');
          await SetAppState.setProfilePic(profileUrl: '');
          emit(SuccessLogOutState());
        }
    );
  }

}
