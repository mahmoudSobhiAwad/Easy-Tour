abstract class HomeTouristState{}
class InitialHomeTouristState extends HomeTouristState{}
class ChangeHomeTouristMenuState extends HomeTouristState{}
class ChangeHomeTouristAnimationState extends HomeTouristState{}
class ChangeHomeTouristNavBottomState extends HomeTouristState{}
class GoToHomeBackState extends HomeTouristState{}
class SuccessLogOutState extends HomeTouristState{}
class SuccessMakeSocketConnect extends HomeTouristState{}
class LoadingMakeSocketConnect extends HomeTouristState{}
class FailureMakeSocketConnect extends HomeTouristState{
  final String?errMessage;
  FailureMakeSocketConnect({this.errMessage});
}
class LoadingLogOutState extends HomeTouristState{}

class FailureLogOutState extends HomeTouristState{
  final String?errMessage;
  FailureLogOutState(this.errMessage);
}
class RefreshTokenErrorState extends HomeTouristState{
  final String?errMessage;
  RefreshTokenErrorState(this.errMessage);
}
class ShowBoxToGoToSettingPage extends HomeTouristState{}
class LoadingSendFcmNotificationState extends HomeTouristState{}
class SuccessSendFcmNotificationState extends HomeTouristState{}
class FailureSendFcmNotificationState extends HomeTouristState{
  final String?errMessage;
  FailureSendFcmNotificationState({this.errMessage});
}
class LoadingGetBestDestinationStata extends HomeTouristState{}
class SuccessGetBestDestinationStata extends HomeTouristState{}
class FailureGetBestDestinationStata extends HomeTouristState{
  final String?errMessage;
  FailureGetBestDestinationStata({this.errMessage});
}