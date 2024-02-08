import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prepare_project/features/tour_guide/profile/data/repos/tour_guide_profile_repo.dart';
import 'package:prepare_project/features/tour_guide/profile/presentation/manager/edit_personal_info_cubit/profile_info_state.dart';
import '../../../data/model/guide_personal_info_model.dart';

class EditProfileInfoGuideCubit extends Cubit<EditGuidePersonalState>{
  EditProfileInfoGuideCubit({required this.personalInfoModel,required this.tourGuideProfileRepo}):super(InitialEditGuidePersonalState());
  TextEditingController addressTextEditingController=TextEditingController();
  TextEditingController firstNameTextEditingController=TextEditingController();
  TextEditingController lastNameTextEditingController=TextEditingController();
  TextEditingController dateTextEditingController=TextEditingController();
  TextEditingController phoneTextEditingController=TextEditingController();
  TextEditingController describeTextEditingController=TextEditingController();
  bool isLoading=false;
  final ImagePicker picker=ImagePicker();
  TourGuideProfileRepo tourGuideProfileRepo;
  String?profileUrl;
  File?profileFile;
  TourGuidePersonalInfoModel? personalInfoModel;
  void editFormField(){
    profileUrl=personalInfoModel?.profileUrl;
    firstNameTextEditingController.text=personalInfoModel?.firstName??"";
    lastNameTextEditingController.text=personalInfoModel?.lastName??"";
    addressTextEditingController.text=personalInfoModel?.address??"";
    dateTextEditingController.text=personalInfoModel?.date??"";
    phoneTextEditingController.text=personalInfoModel?.phoneNumber??"";
    describeTextEditingController.text=personalInfoModel?.describeText??"";
  }
  void updateTourGuideInfo()async{
    FormData infoModel=await TourGuidePersonalInfoModel(
      profileFile: profileFile?.path,
      date: dateTextEditingController.text,
      firstName: firstNameTextEditingController.text,
      lastName: lastNameTextEditingController.text,
      address: addressTextEditingController.text,
      lang: personalInfoModel?.lang??[],
      phoneNumber: phoneTextEditingController.text,
      describeText: describeTextEditingController.text,
    ).updateTourGuideInfo();
    isLoading=true;
    emit(LoadingEditGuidePersonalState());
    var result=await tourGuideProfileRepo.updatePersonalInfo(infoModel: infoModel);
    result.fold((failure){
      isLoading=false;
      emit(FailureEditGuidePersonalState(errMessage: failure.errMessage));
    }, (updatedData)
    {
      isLoading=false;
      emit(SuccessEditGuidePersonalState());
    });

  }
  Future<void> getImageFromCamera()async{
    XFile?pickedFile=await picker.pickImage(source:ImageSource.camera);
    if(pickedFile!=null){
      profileFile=File(pickedFile.path);
      emit(GetImageFromGalleryTourGuideState());
    }
  }
  Future<void> getImageFromGallery()async{
    XFile? pickedFile=await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile!=null){
      profileFile=File(pickedFile.path);
      emit(GetImageFromGalleryTourGuideState());
    }
  }
}