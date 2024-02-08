import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/constant_var/constant.dart';
import 'package:prepare_project/core/utilities/function/crop_image.dart';
import 'package:prepare_project/features/sign_up/data/model/photo_name_enum.dart';
import 'package:prepare_project/features/sign_up/data/model/tour_guide_model.dart';
import 'package:prepare_project/features/sign_up/data/model/toursim_sign_up_model.dart';
import 'package:prepare_project/features/sign_up/data/repos/sign_up_repo.dart';
import 'package:prepare_project/features/sign_up/presentation/manager/sign_up_states.dart';

class SignUpCubit extends Cubit<SignUpStates>{
  SignUpCubit(this.signUpRepo):super(InitialSignUpState());
  final GlobalKey<FormState> touristFormKey=GlobalKey();
  final SignUpRepo?signUpRepo;
  /// tourist var
  TextEditingController emailTextEditingController=TextEditingController();
  TextEditingController confirmPasswordTextEditingController=TextEditingController();
  TextEditingController passwordTextEditingController=TextEditingController();
  TextEditingController nameTextEditingController=TextEditingController();
  ///mutual var
  bool showPassword=true;
  bool showConfirmPassword=true;
  bool showLoading=false;
  int ?toggleRoleIndex=0;
  int progressIndex=0;
  ///tour guide var
  TextEditingController describeEditingController=TextEditingController();
  TextEditingController phoneTextEditingController=TextEditingController();
  TextEditingController addressTextEditingController=TextEditingController();
  TextEditingController lastNameTextEditingController=TextEditingController();
  TextEditingController dateTextEditingController=TextEditingController();
  final ImagePicker picker=ImagePicker();
  String?ministryID;
  String?syndicateID;
  String?profileUrl;
  List<String>languages=[];
  bool enableLangDrop=false;
  Color? borderConfirmColor;
  ///sign up as tour guide function
  void deleteImage(SignUpPhotoName photoName){
    switch(photoName){
      case SignUpPhotoName.ministryId:
        ministryID=null;
      case SignUpPhotoName.nId:
        syndicateID=null;
      case SignUpPhotoName.profile:
        profileUrl=null;
    }
  emit(DeletePhotoOfIdState());

}
  Future<void> getImageFromCamera(SignUpPhotoName photoName)async{
   XFile? imageCamera=await picker.pickImage(source:ImageSource.camera);
    if(imageCamera!=null){
      switch(photoName){
        case SignUpPhotoName.ministryId:
          ministryID=File(imageCamera.path).path;
        case SignUpPhotoName.nId:
          syndicateID=File(imageCamera.path).path;
        case SignUpPhotoName.profile:
          profileUrl=File(imageCamera.path).path;
      }
      emit(GetImageFromCameraState());
    }
  }
  Future<void> getImageFromGallery(SignUpPhotoName photoName)async{
   XFile? imageGallery=await picker.pickImage(source:ImageSource.gallery);
    if(imageGallery!=null){
      switch(photoName){
        case SignUpPhotoName.ministryId:
          ministryID=File(imageGallery.path).path;
        case SignUpPhotoName.nId:
          syndicateID=File(imageGallery.path).path;
        case SignUpPhotoName.profile:
          profileUrl=File(imageGallery.path).path;
      }
      emit(GetImageFromGalleryState());
    }

  }
  void checkExitOfImages(){
    if(ministryID==null||syndicateID==null){
      emit(FrontAndBackImageIsNullState());
    }
    else{
      ++progressIndex;
      emit(NavigateSignUpPageForward());
    }
  }
  bool checkFormFields(){
    if(phoneTextEditingController.text.isNotEmpty&&addressTextEditingController.text.isNotEmpty&&nameTextEditingController.text.isNotEmpty&&lastNameTextEditingController.text.isNotEmpty&&dateTextEditingController.text.isNotEmpty&&languages.isNotEmpty){
      return true;
    }
    else{
      return false;
    }
  }
  void submitDetailsTourGuideForm(){
    if(checkFormFields()){
      ++progressIndex;
      emit(NavigateSignUpPageForward());
    }
    else{
      emit(DetailsIsNullState());
    }
  }
  void backwardProgressIndex(){
    if(progressIndex<=2){
      --progressIndex;
      emit(NavigateSignUpPageBackward());
    }
  }
  Future<void>cropImage(SignUpPhotoName photoName)async{
    String sourcePath='';
   switch(photoName){
     case SignUpPhotoName.ministryId:
       sourcePath=ministryID!;
     case SignUpPhotoName.nId:
       sourcePath=syndicateID!;
     case SignUpPhotoName.profile:
       sourcePath=profileUrl!;
   }
    final cropFile=await getImageCropped(sourcePath);
    if(cropFile!=null){
      emit(EditPhotoOfIdState());
     switch(photoName){
       case SignUpPhotoName.ministryId:
         ministryID=cropFile.path;
       case SignUpPhotoName.nId:
         syndicateID=cropFile.path;
       case SignUpPhotoName.profile:
         profileUrl=cropFile.path;
     }
    }

  }
  void addLanguageToList(String?value){
    languages.add(value!);
    emit(EditLanguageListState());
  }
  void changeCustomDrop(){
    enableLangDrop=!enableLangDrop;
    emit(ChangeMenuSignUpDropState());
  }
  void removeLanguageFromList(String?value){
    languages.remove(value);
    emit(EditLanguageListState());
  }

/// mutual function between tourism and tour-guide
  void submitForm({required Role role})async{
    switch(role){
      case Role.tourist:
        await signUpAsTourist();
      case Role.tourGuide:
        await signUpAsTourGuide();
    }
  }
  void changeToggleIndex(int index){
    toggleRoleIndex=index;
    emit(ChangeToggleRoleIndexState());
  }
  void changeShowing(){
    showPassword=!showPassword;
    emit(ChangeShowPasswordState());
  }
  void changeConfirmShowing(){
    showConfirmPassword=!showConfirmPassword;
    emit(ChangeShowConfirmPasswordState());
  }
  bool checkSignUpCredential(Role role){
    switch(role){
      case Role.tourist:
        if(emailTextEditingController.text.isNotEmpty&&passwordTextEditingController.text.isNotEmpty&&nameTextEditingController.text.isNotEmpty&&passwordTextEditingController.text==confirmPasswordTextEditingController.text){
          return true;
        }
        else{
          return false;
        }
      case Role.tourGuide:
        if(emailTextEditingController.text.isNotEmpty&&passwordTextEditingController.text.isNotEmpty&&passwordTextEditingController.text==confirmPasswordTextEditingController.text){
          return true;
        }
        else{
        return false;
        }
    }

  }
  /// sign up as tourism function
 Future< void> signUpAsTourist()async{
    if(checkSignUpCredential(Role.tourist)==true){
     showLoading=true;
     emit(LoadingSignUpState());
     var result= await signUpRepo?.signUpAsTourist(
         TourismSignUpModel(
           email: emailTextEditingController.text,
           password: passwordTextEditingController.text,
           confirmPassword: confirmPasswordTextEditingController.text,
           name: nameTextEditingController.text,
         )
     );
     result?.fold((failure){
       showLoading=false;
       emit(FailureSignUpState(failure.errMessage));
     }, (tourismInfo)
     async {
       showLoading=true;
       emit(SuccessSignUpState());
     });
    }
    else{
     emit(SignUpCredentialInValid());
    }
  }
 Future<void> signUpAsTourGuide()async{
    if(checkSignUpCredential(Role.tourGuide)){
      showLoading=true;
      emit(LoadingSignUpState());
      languages.add('arabic');
      final FormData formData=await TourGuideSignUpModel(
        email: emailTextEditingController.text,
        profileUrl: profileUrl,
        password: passwordTextEditingController.text,
        lastName: lastNameTextEditingController.text,
        nIdUrl: syndicateID,
        phoneNum: phoneTextEditingController.text,
        tourismId: ministryID,
        address: addressTextEditingController.text,
        date: dateTextEditingController.text,
        lang: languages,
        describe: describeEditingController.text,
        firstName: nameTextEditingController.text,
        confirmPassword: confirmPasswordTextEditingController.text,
      ).toFormData();
      var result= await signUpRepo?.signUpAsTourGuide(formData);
      result?.fold((failure)
      {
        showLoading=false;
        emit(FailureSignUpState(failure.errMessage));
      }, (tourGuideInfo)
      async {
        showLoading=false;
        emit(SuccessTourGuideSignUpState());
      });
    }
    else{
      emit(SignUpCredentialInValid());
    }

  }
  void changeConfirmBorder(){
    if(passwordTextEditingController.text!=confirmPasswordTextEditingController.text){
      borderConfirmColor=closeColor;
    }
    else{
      borderConfirmColor=whatsAppColor;
    }
    emit(ChangeConfirmBorderColor());
  }
}
