abstract class TourGuideHomeStates{}
class InitialTourGuideHomeState extends TourGuideHomeStates{}
class ChangeTourGuideHomeMenuState extends TourGuideHomeStates{}
class ChangeTourGuideHomeAnimationState extends TourGuideHomeStates{}
class LoadingLogOutTourGuideState extends TourGuideHomeStates{}
class SuccessLogOutTourGuideState extends TourGuideHomeStates{}
class LoadingGetRecentChatForTourGuideState extends TourGuideHomeStates{}
class SuccessGetRecentChatForTourGuideState extends TourGuideHomeStates{}
class FailureGetRecentChatForTourGuideState extends TourGuideHomeStates{
  final String?errMessage;
  FailureGetRecentChatForTourGuideState({this.errMessage});
}
class FailureLogOutTourGuideState extends TourGuideHomeStates{
  final String? errMessage;
  FailureLogOutTourGuideState( this.errMessage);
}
class RefreshTokenErrorState extends TourGuideHomeStates{
  final String? errMessage;
  RefreshTokenErrorState( this.errMessage);
}
