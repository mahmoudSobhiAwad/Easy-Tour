abstract class EditProfileStates {}
class InitialEditProfileState extends EditProfileStates {}
class SuccessEditProfileState extends EditProfileStates {}
class LoadingEditProfileState extends EditProfileStates {}
class FailureEditProfileState extends EditProfileStates {
  final String?errMessage;
  FailureEditProfileState({this.errMessage});
}
class ChangeGenderSuccessState extends EditProfileStates{}
class ChangeLanguageSuccessState extends EditProfileStates{}
class ChangeCountrySuccessState extends EditProfileStates{}
class AddItemInPrefsListState extends EditProfileStates{}
class RemoveItemFromPrefsListState extends EditProfileStates{}
class GetImageFromGalleryState extends EditProfileStates{}
class EditPhotoOfIdState extends EditProfileStates{}
class ChangeShowEditWidgetState extends EditProfileStates{}
class ChangeMenuDropState extends EditProfileStates{}