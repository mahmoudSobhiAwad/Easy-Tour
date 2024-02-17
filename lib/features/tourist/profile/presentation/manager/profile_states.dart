abstract class ProfileStates{}
class InitialProfileState extends ProfileStates {}
class LoadingGetInfoTouristDataState extends ProfileStates{}
class FailureGetInfoTouristDataState extends ProfileStates{
  final String?errMessage;
  FailureGetInfoTouristDataState(this.errMessage);
}
class SuccessGetInfoTouristDataState extends ProfileStates{}
class LoadingSetUpProfileDataState extends ProfileStates{}
class FailureUpdateInfoTouristDataState extends ProfileStates{
  final String?errMessage;
  FailureUpdateInfoTouristDataState(this.errMessage);
}
class RefreshTokenFailureState extends ProfileStates{
  final String?errMessage;
  RefreshTokenFailureState(this.errMessage);
}
class SuccessUpdateInfoTouristDataState extends ProfileStates{}
class ChangeGenderSuccessState extends ProfileStates{}
class ChangeLanguageSuccessState extends ProfileStates{}
class ChangeCountrySuccessState extends ProfileStates{}
class AddItemInPrefsListState extends ProfileStates{}
class RemoveItemFromPrefsListState extends ProfileStates{}
class GetImageFromGalleryState extends ProfileStates{}
class EditPhotoOfIdState extends ProfileStates{}
class ChangeShowEditWidgetState extends ProfileStates{}
class ChangeMenuDropState extends ProfileStates{}
