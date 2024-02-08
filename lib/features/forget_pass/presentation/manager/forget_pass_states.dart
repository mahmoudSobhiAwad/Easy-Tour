abstract class ForgetPasswordState{}
class InitialForgetPasswordState extends ForgetPasswordState{}

class LoadingSendEmailForForgetPassState extends ForgetPasswordState{}

class ErrorSendEmailForForgetPassState extends ForgetPasswordState{
  String? errMessage;
  ErrorSendEmailForForgetPassState({required this.errMessage});
}

class SuccessSendEmailForForgetPassState extends ForgetPasswordState{}

class LoadingResetPasswordState extends ForgetPasswordState{}

class ErrorResetPasswordState extends ForgetPasswordState{
  String?errorChangePassword;
  ErrorResetPasswordState({required this.errorChangePassword});
}

class SuccessResetPasswordState extends ForgetPasswordState{}

class ChangeToggleRoleIndexState extends ForgetPasswordState{}

class OtpCodeFailedState extends ForgetPasswordState{}

class NavigateResetContinueForward extends ForgetPasswordState{}

class NavigateResetContinueBackward extends ForgetPasswordState{}

class ChangePasswordVisibility extends ForgetPasswordState{}

class ChangeConfirmPasswordVisibility extends ForgetPasswordState{}