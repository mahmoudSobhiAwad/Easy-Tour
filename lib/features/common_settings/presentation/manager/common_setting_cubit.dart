import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/theme_style/theme_mode.dart';
import 'package:prepare_project/features/common_settings/presentation/manager/common_setting_states.dart';
import 'package:prepare_project/features/tourist/settings/data/model/put_notify_model.dart';
import 'package:prepare_project/features/tourist/settings/data/repo/setting_repo_imp.dart';

class CommonSettingCubit extends Cubit<CommonSettingState>{
  CommonSettingCubit({required this.settingRepoImp}):super(InitialTourGuideSettingState());
  bool enableDarkMode=false;
  bool enableNotification=false;
  ThemeData appTheme=lightMode;
  ThemeMode appMode=ThemeMode.light;
  final SettingRepoImp settingRepoImp;
  void changeMode(){
    if(appTheme ==lightMode){
      appTheme=darkMode;
      enableDarkMode=true;
      appMode=ThemeMode.dark;
    }
    else{
      appTheme=lightMode;
      enableDarkMode=false;
      appMode=ThemeMode.light;
    }
    emit(ChangeToggleOfModeState());
  }
  Future<void>checkAllowingNotify()async{
    await AwesomeNotifications().isNotificationAllowed().then((allowed) async {
      if(allowed){
        enableNotification=true;
        await getFcmToken('enable');
        emit(ChangeNotificationModeState());
      }
    });
  }
  void changeNotificationMode()async{
    if(enableNotification){
      await AwesomeNotifications().dismissAllNotifications();
      enableNotification=false;
      getFcmToken('disable');
      emit(ChangeNotificationModeState());
    }
    else{
      await AwesomeNotifications().requestPermissionToSendNotifications().then((value){
        checkAllowingNotify();
      });
    }
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

}