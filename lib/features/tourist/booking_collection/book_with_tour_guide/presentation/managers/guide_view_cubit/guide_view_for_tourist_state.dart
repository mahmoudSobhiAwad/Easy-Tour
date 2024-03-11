abstract class GuideViewForTouristState{}
class InitialGuideViewForTouristState extends GuideViewForTouristState{}
class LoadingGetGuideViewForTouristState extends GuideViewForTouristState{}
class SuccessGetGuideViewForTouristState extends GuideViewForTouristState{}
class FailureGetGuideViewForTouristState extends GuideViewForTouristState{
  final String? errMessage;
  FailureGetGuideViewForTouristState({this.errMessage});
}
