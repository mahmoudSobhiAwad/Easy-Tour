abstract class HomeTouristState{}
class InitialHomeTouristState extends HomeTouristState{}
class ChangeHomeTouristMenuState extends HomeTouristState{}
class ChangeHomeTouristAnimationState extends HomeTouristState{}
class ChangeHomeTouristNavBottomState extends HomeTouristState{}
class SuccessLogOutState extends HomeTouristState{}
class LoadingLogOutState extends HomeTouristState{}
class FailureLogOutState extends HomeTouristState{
  final String?errMessage;
  FailureLogOutState(this.errMessage);
}