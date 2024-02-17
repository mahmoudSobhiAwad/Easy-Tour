import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/widget/change_passowrd/data/models/passowrd_model.dart';
import 'package:prepare_project/core/widget/change_passowrd/data/repos/change_password_repo.dart';
import 'package:prepare_project/core/widget/change_passowrd/presentation/manager/change_pass_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState>{
  ChangePasswordCubit({required this.changePasswordRepo}):super(InitialChangePasswordState());
  final TextEditingController passwordController=TextEditingController();
  final TextEditingController newPasswordController=TextEditingController();
  final TextEditingController newConfirmPasswordController=TextEditingController();
  bool oldPassVis=true;
  bool newPassVis=true;
  bool confirmNewPassVis=true;
  bool checkOldPass=false;
  final ChangePasswordRepo changePasswordRepo;
  final GlobalKey<FormState> formKey=GlobalKey();
  void changePassVisibility(bool icon)
  {
    icon=!icon;
    emit(ChangeVisibilityPasswordState());
  }
  void changeOldVisibility(){
    oldPassVis=!oldPassVis;
    emit(ChangeVisibilityPasswordState());
  }
  void changeNewVisibility(){
    newPassVis=!newPassVis;
    emit(ChangeVisibilityPasswordState());
  }
  void changeNewConfirmVisibility(){
    confirmNewPassVis=!confirmNewPassVis;
    emit(ChangeVisibilityPasswordState());
  }
  bool matchingPasswords(){
    if(newPasswordController.text!=newConfirmPasswordController.text)
    {
      emit(FailureMatchingPasswordsState());
      return false;
    }
    else{
      emit(SuccessMatchingPasswordsState());
      return true;
    }
  }
  Future<void> checkOldPassword()async {
    var response=await changePasswordRepo.checkOldPassword(oldPass: passwordController.text);
    response.fold((failure)
    {
      if(failure.statusCode==401)
      {
        emit(RefreshTokenFailureState('Unknown Error,Please try again'));
      }
      else
      {
      emit(FailureOldPasswordState(failure.errMessage));
      }
    }, (message)
    {
      emit(SuccessOldPasswordState());

    });

  }
  Future<void> changeNewPassword()async{
    if(formKey.currentState!.validate()){
      if(checkOldPass==true) {
        if(matchingPasswords()){
          await checkNewPassword();
        }
      }
      else{
        checkOldPassword().then((value) async{
          if(state is SuccessOldPasswordState){
            checkOldPass=true;
            if(matchingPasswords()){
              await checkNewPassword();
            }
          }
        });
      }
    }
  }
  Future<void> checkNewPassword()async{
    var response=await changePasswordRepo.updateNewPassword(
        passwords:ChangePasswordModel(
            newPass: newPasswordController.text,
            confirmNewPas: newConfirmPasswordController.text).toJson()
    );
    response.fold((failure)
    {
      emit(FailureNewPasswordState(failure.errMessage));
    }, (message)
    {
      emit(SuccessNewPasswordState());
    });

  }
}




