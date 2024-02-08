import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/function/set_app_state.dart';
import 'package:prepare_project/core/widget/delete_account/data/repos/delete_acc_repo.dart';
import 'package:prepare_project/core/widget/delete_account/presentation/manager/delete_account_states.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState>{
  DeleteAccountCubit({required this.deleteAccountRepo}):super(InitialChangePasswordState());
  final TextEditingController passwordController=TextEditingController();
  bool oldPassVis=true;
  bool checkOldPass=false;
  final GlobalKey<FormState> formKey=GlobalKey();
  final DeleteAccRepo deleteAccountRepo;
  Future<void> deleteAccount()async{
    emit(LoadingDeleteAccountState());
    if(formKey.currentState!.validate()) {
      checkOldPassword().then((value) async{
        if (state is SuccessCheckOldPasswordState ){
          var response=await deleteAccountRepo.deleteAccount();
          response.fold(
                  (failure){
                    print(failure.errMessage);
                emit(FailureDeleteAccountState(errMessage:failure.errMessage??""));
              }, (delete)async{
            emit(SuccessDeleteAccountState());
            await SetAppState.setToken(token: '');
          });
        }
      });
    }
  }
  void changeOldPassVis(){
    oldPassVis=!oldPassVis;
    emit(ChangeOldPassVisibility());
  }
  Future<void> checkOldPassword()async {
    var response=await deleteAccountRepo.checkOldPassword(oldPass: passwordController.text);
    response.fold((failure)
    {
      emit(FailureCheckOldPasswordState(errMessage:failure.errMessage));
    }, (message)
    {
      emit(SuccessCheckOldPasswordState());

    });

  }
}




