abstract class SignUpStates{}
class InitialSignUpState extends SignUpStates {}
class NavigateSignUpPageForward extends SignUpStates {}
class NavigateSignUpPageBackward extends SignUpStates {}
class ChangeShowPasswordState extends SignUpStates {}
class PasswordIsNotIdenticalSignUpState extends SignUpStates {}
class GetImageFromGalleryState extends SignUpStates {}
class GetImageFromCameraState extends SignUpStates {}
class ChangeShowConfirmPasswordState extends SignUpStates {}
class ChangeToggleRoleIndexState extends SignUpStates{}
class SuccessSignUpState extends SignUpStates {}
class SuccessTourGuideSignUpState extends SignUpStates {}
class LoadingSignUpState extends SignUpStates {}
class SignUpCredentialInValid extends SignUpStates{}
class FailureSignUpState extends SignUpStates {
  final String? error;
  FailureSignUpState(this.error);
}
class FrontAndBackImageIsNullState extends SignUpStates{}
class DeletePhotoOfIdState extends SignUpStates{}
class EditPhotoOfIdState extends SignUpStates{}
class ThereIsNoInternetState extends SignUpStates{}
class ChangeMenuSignUpDropState extends SignUpStates{}
class EditLanguageListState extends SignUpStates{}
class DetailsIsNullState extends SignUpStates{}
class ChangeConfirmBorderColor extends SignUpStates{}


