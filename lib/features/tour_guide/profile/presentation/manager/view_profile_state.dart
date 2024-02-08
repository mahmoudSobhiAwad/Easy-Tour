abstract class TourGuideProfileViewState{}
class InitialTourGuideProfileView extends TourGuideProfileViewState{}
class LoadingGetInfoTourGuideProfileView extends TourGuideProfileViewState{}
class SuccessGetInfoTourGuideProfileView extends TourGuideProfileViewState{}
class FailureGetInfoTourGuideProfileView extends TourGuideProfileViewState{
  final String? errMessage;
  FailureGetInfoTourGuideProfileView({required this.errMessage});
}
class FailureOpenAppUrlState extends TourGuideProfileViewState{
  final String errMessage;
  FailureOpenAppUrlState({required this.errMessage});
}