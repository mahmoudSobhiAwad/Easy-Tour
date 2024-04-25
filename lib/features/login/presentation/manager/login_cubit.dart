import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/function/set_app_state.dart';
import 'package:prepare_project/features/login/data/model/toursim_sign_in_model.dart';
import 'package:prepare_project/features/login/data/repos/log_in_repo.dart';
import 'package:prepare_project/features/login/presentation/manager/login_state.dart';
import '../../../../core/utilities/constant_var/constant.dart';

class LoginCubit extends Cubit<LoginState>{
  LoginCubit({required this.loginRepo,}):super(InitialLoginState());
  final LoginRepo loginRepo;
  TextEditingController emailController=TextEditingController();
  TextEditingController passController=TextEditingController();
  TextEditingController emailTourGuideController=TextEditingController();
  TextEditingController passTourGuideController=TextEditingController();
   bool showPass=true;
   bool showLoading=false;
   int toggleRoleIndex=0;
   Role role=Role.tourist;
   FocusNode emailFocusNode=FocusNode();
   FocusNode passFocusNode=FocusNode();
///function related to tourist And TourGuide
  void changeToggleIndex(int index){
    toggleRoleIndex=index;
    index!=0?role=Role.tourGuide:role=Role.tourist;
    emit(ChangeToggleRoleIndexState());
  }
  //complete login function
  Future<void> completeLogin()async{
    switch(role){
      case Role.tourist:
        await loginAsTourism();
      case Role.tourGuide:
        await loginAsTourGuide();
    }
  }

  /// login as tourism functions
  Future<void> loginAsTourism()async{
    showLoading=true;
    if(emailController.text.isEmpty&&passController.text.isEmpty){
      emit(FailureLoginState(errorLogin: 'Email Or Password Can\'t be Empty'));
      showLoading=false;
    }
    else{
    emit(LoadingLoginState());
    var result=await loginRepo.loginAsTourism(
      TourismSignInModel(
        email: emailController.text,
        password: passController.text).toJson(),
    );
     result.fold((failure){
      showLoading=false;
      emit(FailureLoginState(errorLogin: failure.errMessage));
    }, (tourismInfo)async
     {
       if(tourismInfo.confirm==true){
        await SetAppState.setToken(token:tourismInfo.token);
        await SetAppState.setRole(role:'tourist');
        await SetAppState.setName(name:tourismInfo.name);
        await SetAppState.setEmail(email:tourismInfo.email);
        showLoading=false;
        emit(SuccessLoginState());
      }
      else{
        showLoading=false;
        emit(FailureLoginState(errorLogin: 'Please Confirm Your Account First'));
      }
    });
    }
  }
  ///login as tour guide
  Future<void> loginAsTourGuide()async{
    if(emailTourGuideController.text.isNotEmpty&&passTourGuideController.text.isNotEmpty){
      showLoading=true;
      emit(LoadingLoginState());
      var result=await loginRepo.loginAsTourGuide(
        TourismSignInModel(
          email: emailTourGuideController.text,
          password: passTourGuideController.text).toJson(),
      );
       result.fold((failure){
        showLoading=false;
        emit(FailureLoginState(errorLogin: failure.errMessage));
      }, (tourGuideInfo)async
       {
        if(tourGuideInfo.confirmAcc!){
          await SetAppState.setToken(token:tourGuideInfo.token);
          await SetAppState.setRole(role:'tourGuide');
          await SetAppState.setName(name:'${tourGuideInfo.firstName}${tourGuideInfo.lastName}');
          await SetAppState.setEmail(email:tourGuideInfo.email);
          showLoading=false;
          emit(SuccessTourGuideLoginState());
        }
        else{
          showLoading=false;
          emit(FailureLoginState(errorLogin: 'Please Confirm Your Account First'));
        }
      });
    }
    else{
      emit(FailureLoginState(errorLogin: 'Email Or Password Can\'t be Empty'));
      showLoading=false;
    }
  }

  Future<void>signInWithGoogle()async{
    //f1K8HRVtSvq4JABvQwD1aI:APA91bE7bQaKuiwWUTW3zogt5wlW1--g1MdOTYjBkLSxsZsIqdw2V4swcXDWL4EtsuIo4CbuOWdy3qth8-cIwg9HNBATE3KWaDcyrJV0HdEHbZHv3JSsrRQwnBIxbRgCk84CE459QB5K
  }
  /// ForgetPass functions
  void changeShow(){

    showPass=!showPass;
    emit(EnablePasswordState());
  }


}