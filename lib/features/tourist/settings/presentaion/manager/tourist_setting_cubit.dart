import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/theme_style/theme_mode.dart';
import 'package:prepare_project/features/tourist/settings/presentaion/manager/tourist_setting_state.dart';

class TouristSettingCubit extends Cubit<TouristSettingState>{
  TouristSettingCubit():super(InitialTouristSettingState());
bool enableDarkMode=false;
bool enableNotification=false;
ThemeData appTheme=lightMode;
ThemeMode appMode=ThemeMode.light;
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
}