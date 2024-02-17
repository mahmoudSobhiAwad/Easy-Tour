abstract class ChangePasswordState {}
class InitialChangePasswordState extends ChangePasswordState{}
class ChangeVisibilityPasswordState extends ChangePasswordState{}

class FailureMatchingPasswordsState extends ChangePasswordState{}
class SuccessMatchingPasswordsState extends ChangePasswordState{}

class SuccessOldPasswordState extends ChangePasswordState{}
class LoadingOldPasswordState extends ChangePasswordState{}
class FailureOldPasswordState extends ChangePasswordState{
  final String? errMessage;
  FailureOldPasswordState(this.errMessage);
}

class SuccessNewPasswordState extends ChangePasswordState{}
class LoadingNewPasswordState extends ChangePasswordState{}
class FailureNewPasswordState extends ChangePasswordState{
  final String?errMessage;
  FailureNewPasswordState(this.errMessage);
}
class RefreshTokenFailureState extends ChangePasswordState{
  final String?errMessage;
  RefreshTokenFailureState(this.errMessage);
}