abstract class DeleteAccountState {}
class InitialChangePasswordState extends DeleteAccountState{}
class ChangeOldPassVisibility extends DeleteAccountState{}

class LoadingCheckOldPasswordState extends DeleteAccountState{}
class SuccessCheckOldPasswordState extends DeleteAccountState{}
class FailureCheckOldPasswordState extends DeleteAccountState{
  final String?errMessage;
  FailureCheckOldPasswordState({required this.errMessage});}
class RefreshTokenFailureState extends DeleteAccountState{
  final String?errMessage;
  RefreshTokenFailureState({required this.errMessage});}
class LoadingDeleteAccountState extends DeleteAccountState{}
class SuccessDeleteAccountState extends DeleteAccountState{}
class FailureDeleteAccountState extends DeleteAccountState{
  final String errMessage;
  FailureDeleteAccountState({required this.errMessage});
}