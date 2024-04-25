abstract class HomeTouristState{}
class InitialHomeTouristState extends HomeTouristState{}
class ChangeHomeTouristMenuState extends HomeTouristState{}
class ChangeHomeTouristAnimationState extends HomeTouristState{}
class ChangeHomeTouristNavBottomState extends HomeTouristState{}
class GoToHomeBackState extends HomeTouristState{}
class SuccessLogOutState extends HomeTouristState{}
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
