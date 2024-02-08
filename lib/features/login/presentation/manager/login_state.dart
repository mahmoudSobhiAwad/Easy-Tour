abstract class LoginState{}
class InitialLoginState extends LoginState{}
class EnablePasswordState extends LoginState{}
class LoadingLoginState extends LoginState{}
class ChangeToggleRoleIndexState extends LoginState{}
class SuccessLoginState extends LoginState{}
class SuccessTourGuideLoginState extends LoginState{}
class FailureLoginState extends LoginState{
  String?errorLogin;
  FailureLoginState({required this.errorLogin});
}

class LoadingLoginWithGoogleState extends LoginState{}
class SuccessLoginWithGoogleState extends LoginState{}

