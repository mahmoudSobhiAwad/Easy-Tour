import 'dart:developer';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/constant_var/constant.dart';
import 'package:prepare_project/core/utilities/notification_setup/notification_setup.dart';
import 'package:prepare_project/features/tourist/settings/data/repo/setting_repo_imp.dart';
import 'package:prepare_project/features/tourist/tourist_home/data/repo/home_tourist_repo_impl.dart';
import 'package:prepare_project/features/tourist/tourist_home/presentaion/manager/home_tourist_state.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../../../../core/utilities/function/set_app_state.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../../settings/data/model/put_notify_model.dart';

class HomeTouristCubit extends Cubit<HomeTouristState>{
  HomeTouristCubit({required this.controller,required this.settingRepoImp,required this.homeTouristRepoImp}):super(InitialHomeTouristState());
  bool isMenuActive=false;
  final AnimationController? controller;
  final String?touristName= SetAppState.prefs?.getString('name');
  final String sourceEmail=SetAppState.prefs?.getString('email')??"";
  String profileUrl= SetAppState.prefs?.getString('profileUrl')??'';
  final HomeTouristRepoImp homeTouristRepoImp;
  final SettingRepoImp settingRepoImp;
  int currIndex=0;
  bool allowedNotification=false;
  late io.Socket socket ;
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
  void connect(){
    socket = io.io(baseUrl,
        OptionBuilder()
            .setTransports(['websocket'])// for Flutter or Dart VM
            .disableAutoConnect()  // disable auto-connection
            .setExtraHeaders({'email': sourceEmail}) // optional
            .build()
    );
    socket.connect();
    socket.onConnect((data) {
      socket.on("receiveMessage", (data) {
        log('Listening Now To Socket');
      });
    });
    socket.onDisconnect((_) => debugPrint('disconnect'));
  }
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
    await makeDataNull();
    emit(LoadingLogOutState());
    var result =await homeTouristRepoImp.logOut();
    result.fold(
        (failure) async {
          if(failure.statusCode==401)
          {
            await logOut();
          }
          else if(failure.statusCode==500){
            await makeDataNull();
            emit(SuccessLogOutState());
          }
          else{
          emit(FailureLogOutState(failure.errMessage));
          }
        }, (logOut) async {
          await makeDataNull();
          emit(SuccessLogOutState());
        }
    );
  }

  Future<void> makeDataNull() async {
     await SetAppState.setToken(token: '');
    await SetAppState.setRole(role: '');
    await SetAppState.setEmail(email: '');
    await SetAppState.setProfilePic(profileUrl: '');
  }
  void goToHome(){
    currIndex=0;
    emit(GoToHomeBackState());
  }
  Future<void>checkAllowingNotify()async{
   await AwesomeNotifications().isNotificationAllowed().then((allowed){
      if(!allowed){
        emit(ShowBoxToGoToSettingPage());
      }
      else{
        allowedNotification=true;
        //getFcmToken('enable');
      }
    });
  }
  Future<void> getFcmToken(String enableType)async{
    final fcmToken = await FirebaseMessaging.instance.getToken();
    emit(LoadingSendFcmNotificationState());
    var result=await settingRepoImp.sendFcmDevice(SendFcmModel(enable:enableType,fcmDevice: fcmToken).toJson());
    result.fold((failure){
      debugPrint(failure.errMessage);
      emit(FailureSendFcmNotificationState(errMessage: failure.errMessage));
    }, (success){
      emit(SuccessSendFcmNotificationState());
    });
  }

  Future<void>configurePushNotification()async{
    checkAllowingNotify();
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onBackgroundMessage((message)async {
      return await myBackGroundMessageHandler(message);
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async{
      if(message.notification !=null){
        NotificationSetup().createOrderNotification(message.notification?.title, message.notification?.body, requestNotificationChannel);
      }
    });
  }
}
@pragma("vm:entry-point")
Future<dynamic>myBackGroundMessageHandler(RemoteMessage message)async{
  await Firebase.initializeApp();}