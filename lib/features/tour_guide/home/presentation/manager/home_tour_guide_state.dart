abstract class TourGuideHomeStates{}
class InitialTourGuideHomeState extends TourGuideHomeStates{}
class ChangeTourGuideHomeMenuState extends TourGuideHomeStates{}
class ChangeTourGuideHomeAnimationState extends TourGuideHomeStates{}
class LoadingLogOutTourGuideState extends TourGuideHomeStates{}
class SuccessLogOutTourGuideState extends TourGuideHomeStates{}
class FailureLogOutTourGuideState extends TourGuideHomeStates{
  final String? errMessage;
  FailureLogOutTourGuideState( this.errMessage);
}
