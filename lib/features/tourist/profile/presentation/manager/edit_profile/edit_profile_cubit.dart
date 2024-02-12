import 'dart:io';
import 'package:country_picker/country_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prepare_project/core/utilities/function/set_app_state.dart';
import 'package:prepare_project/features/tourist/profile/data/models/tourist_info_model.dart';
import 'package:prepare_project/features/tourist/profile/data/repos/profile_repo.dart';
import 'package:prepare_project/features/tourist/profile/presentation/manager/edit_profile/edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileStates>{
  EditProfileCubit({required this.profileRepo,required this.model}):super(InitialEditProfileState());
  final ProfileRepo profileRepo;
  final TouristInfoModel? model;
  String?country;
  String?flag;
  String? coverUrl;
  String? imageUrl;
  String?countryCode='20';
  String?gender;
  String?language;
  bool showGetLoading=false;
  File?profileFile;
  File?coverFile;
  bool showPrefDrop=false;
  String?name=SetAppState.prefs?.getString('name');
  TextEditingController phoneController=TextEditingController();
  Set preferences={};
  final ImagePicker picker=ImagePicker();
  void prepareField(){
    country=model?.nationality;
    flag=model?.flagName??'EG';
    imageUrl=model?.profileUrl??"";
    coverUrl=model?.coverUrl??"";
    gender=model?.gender;
    language=model?.languages;
    preferences=model?.preferences?.toSet()??{};
    phoneController.text=model?.phoneNumber??'';
  }
  Future<void>updateProfileDate()async {
    final FormData formData=await TouristInfoModel(
      profileFile: profileFile,
      coverFile: coverFile,
      preferences: preferences.toList(),
      nationality: country,
      gender: gender,
      languages: language,
      phoneNumber: phoneController.text,
      flagName: flag,
    ).toFormData();
    showGetLoading=true;
    emit(LoadingEditProfileState());
    var result=await profileRepo.updateTourismInfo(infoModel: formData,);
    return result.fold((failure) {
      showGetLoading=false;
      emit(FailureEditProfileState(errMessage:failure.errMessage));
    }, (tourismInfo) {
      showGetLoading=false;
      emit(SuccessEditProfileState());
      profileFile=coverFile=null;
    });
  }
  void editGender(String?value){
    gender=value;
    emit(ChangeGenderSuccessState());
  }
  void editCountry(Country?value){
    country=value?.name;
    flag=value?.flagEmoji.toString();
    emit(ChangeCountrySuccessState());
  }
  void editLang(String?value){
    language=value;
    emit(ChangeLanguageSuccessState());
  }
  void editListOfPrefs(String?value){
    preferences.add(value!);
    emit(AddItemInPrefsListState());
  }
  void removeFromPrefs(String?value){
    preferences.remove(value);
    emit(RemoveItemFromPrefsListState());
  }
  Future<void> getImageFromCamera(String?photoName)async{
    XFile?imageCamera=await picker.pickImage(source:ImageSource.camera);
    if(imageCamera!=null){
      if(photoName=='profile'){
        profileFile=File(imageCamera.path);
      }
      else if(photoName=='cover'){
        coverFile=File(imageCamera.path);
      }
      emit(GetImageFromGalleryState());
    }
  }
  Future<void> getImageFromGallery(String?photoName)async{
    XFile? pickedFile=await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile!=null){
      if(photoName=='profile'){
        profileFile=File(pickedFile.path);
      }
      else if(photoName=='cover'){
        coverFile=File(pickedFile.path);
      }
      emit(GetImageFromGalleryState());
    }
  }
  void changePrefsMenuDrop()
  {
    showPrefDrop=!showPrefDrop;
    emit(ChangeMenuDropState());
  }

}