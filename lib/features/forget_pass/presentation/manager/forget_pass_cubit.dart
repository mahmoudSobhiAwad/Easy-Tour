import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/function/set_app_state.dart';
import 'package:prepare_project/features/forget_pass/data/repo/forget_pass_repo.dart';
import 'package:prepare_project/features/forget_pass/presentation/manager/forget_pass_states.dart';
import '../../../../core/utilities/constant_var/constant.dart';

class ForgetPassCubit extends Cubit<ForgetPasswordState>{
  ForgetPassCubit({required this.forgetPassRepo}):super(InitialForgetPasswordState());
  final ForgetPassRepo forgetPassRepo;
  bool showPass=true;
  bool showConfirmPass=true;
  bool showLoading=false;
  int toggleRoleIndex=0;
  Role role=Role.tourist;
  int progressTouristIndex=0;
  int progressTourGuideIndex=0;
  String?resetPasswordCode;
  final GlobalKey<FormState> otpKey=GlobalKey();
  TextEditingController emailTouristController=TextEditingController();
  TextEditingController passTouristController=TextEditingController();
  TextEditingController emailTourGuideController=TextEditingController();
  TextEditingController passTourGuideController=TextEditingController();
  TextEditingController confirmPassController=TextEditingController();
  TextEditingController otpController=TextEditingController();
  void changeShow(){
    showPass=!showPass;
    emit(ChangePasswordVisibility());
  }
  void changeConfirmShow(){
    showConfirmPass=!showConfirmPass;
    emit(ChangeConfirmPasswordVisibility());
  }
  bool validatorForgerPass(){
    if(otpKey.currentState!.validate()){
      return true;
    }
    return false;
  }
  void changeToggleIndex(int index){
    toggleRoleIndex=index;
    index!=0?role=Role.tourGuide:role=Role.tourist;
    emit(ChangeToggleRoleIndexState());
  }
  //forget password related to tour guide and tourist
  void forgetPasswordForBothRole()async{
    switch(role){
      case Role.tourist:
        await forgetTouristPassword();
      case Role.tourGuide:
        await forgetTourGuidePassword();
    }
  } //first method
  void checkOtp(){
    print(otpController.text);
    if(validatorForgerPass()){
      if(otpController.text==resetPasswordCode)
      {
        switch(role){
          case Role.tourist:
            ++progressTouristIndex;
          case Role.tourGuide:
            ++progressTourGuideIndex;
        }
        emit(NavigateResetContinueForward());
      }
      else{
        otpController.clear();
        emit(OtpCodeFailedState());
      }
    }
  }//second method mutual between tour guide and tourist
  void resetPasswordForBothRole()async{
    switch(role){
      case Role.tourist:
        await resetTouristPassword();
      case Role.tourGuide:
        await resetTourGuidePassword();
    }
  }
  void backwardProgressIndex(){
    switch(role){
      case Role.tourist:
        if(progressTouristIndex<=2){
          --progressTouristIndex;
          otpController.clear();
          emit(NavigateResetContinueBackward());
        }
      case Role.tourGuide:
        if(progressTourGuideIndex<=2){
          --progressTourGuideIndex;
          otpController.clear();
          emit(NavigateResetContinueBackward());
        }
    }

  }
  ///forget pass for tourist
  Future<void> forgetTouristPassword()async {
    if(emailTouristController.text.isNotEmpty){
      showLoading=true;
      emit(LoadingSendEmailForForgetPassState());
      var result=await forgetPassRepo.sendEmailForgetTouristPassword({"email":emailTouristController.text});
      result.fold((failure){
        showLoading=false;
        emit(ErrorSendEmailForForgetPassState(errMessage:failure.errMessage));
      }, (resetModel) {
        resetPasswordCode=resetModel.resetCode;
        SetAppState.setToken(token: resetModel.token);
        showLoading=false;
        emit(SuccessSendEmailForForgetPassState());
        if(resetPasswordCode!=null){
          otpController.clear();
          ++progressTouristIndex;
        }
      });
    }
    else{
      emit(ErrorSendEmailForForgetPassState(errMessage:'Email Mus\'t Not Be Empty'));
    }
  }//first method to send code according to email
  Future<void>resetTouristPassword()async{
    print(SetAppState.prefs?.get('token'));
    if(passTouristController.text==confirmPassController.text&&passTouristController.text.isNotEmpty){
      showLoading=true;
      emit(LoadingResetPasswordState());
      var result=await forgetPassRepo.resetTouristPassword({"newPassword":passTouristController.text},);
      result.fold((failure){
        showLoading=false;
        print(failure.errMessage);
        emit(ErrorResetPasswordState(errorChangePassword: failure.errMessage));
      }, (model){
        showLoading=false;
        emit(SuccessResetPasswordState());
        SetAppState.setToken(token:'');
      });
    }
    else{
      emit(ErrorResetPasswordState(errorChangePassword: 'Password And Confirm Password are Not  Identical'));
    }
  } //third method to reset password
  /// forget pass for tourGuide
  Future<void> forgetTourGuidePassword()async {
    if(emailTourGuideController.text.isNotEmpty){
      showLoading=true;
      emit(LoadingSendEmailForForgetPassState());
      var result=await forgetPassRepo.sendEmailForgetTourGuidePassword({"email":emailTourGuideController.text});
      result.fold((failure){
        showLoading=false;
        emit(ErrorSendEmailForForgetPassState(errMessage:failure.errMessage));
      }, (resetModel) {
        resetPasswordCode=resetModel.resetCode;
        SetAppState.setToken(token: resetModel.token);
        showLoading=false;
        emit(SuccessSendEmailForForgetPassState());
        if(resetPasswordCode!=null){
          otpController.clear();
          ++progressTourGuideIndex;
        }
      });
    }
    else{
      emit(ErrorSendEmailForForgetPassState(errMessage:'Email Mus\'t Not Be Empty'));
    }
  }
  Future<void>resetTourGuidePassword()async {
    if(passTourGuideController.text==confirmPassController.text&&passTourGuideController.text.isNotEmpty){
      showLoading=true;
      emit(LoadingResetPasswordState());
      var result=await forgetPassRepo.resetTourGuidePassword({"newPassword":passTourGuideController.text});
      result.fold((failure){
        showLoading=false;
        emit(ErrorResetPasswordState(errorChangePassword: failure.errMessage));
      }, (model){
        showLoading=false;
        emit(SuccessResetPasswordState());
        SetAppState.setToken(token:'');
      });
    }
    else{
      emit(ErrorResetPasswordState(errorChangePassword: 'Password And Confirm Password are Not  Identical'));
    }
  }
}