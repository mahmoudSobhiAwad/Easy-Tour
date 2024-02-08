abstract class ContactInfoState{}
class InitialContactInfoSate extends ContactInfoState{}
class AddLinkToContactInfoSate extends ContactInfoState{}
class EditContactInfoSate extends ContactInfoState{}
class RemoveContactInfoSate extends ContactInfoState{}
class ChangeEnableDragSocialList extends ContactInfoState{}
class ChangeInitialSocialValue extends ContactInfoState{}
class ChangeShowBottomSheet extends ContactInfoState{}
class LoadingInitialSocialLinks extends ContactInfoState{}
class LoadingUpdateContactInfo extends ContactInfoState {}
class FailureUpdateContactInfo extends ContactInfoState {
  final String?errMessage;
  FailureUpdateContactInfo({this.errMessage});
}
class SuccessUpdateContactInfo extends ContactInfoState {}
