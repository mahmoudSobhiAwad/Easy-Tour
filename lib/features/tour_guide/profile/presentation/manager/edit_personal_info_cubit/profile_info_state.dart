abstract class EditGuidePersonalState{}
class InitialEditGuidePersonalState extends EditGuidePersonalState{}
class LoadingEditGuidePersonalState extends EditGuidePersonalState{}
class SuccessEditGuidePersonalState extends EditGuidePersonalState{}
class GetImageFromGalleryTourGuideState extends EditGuidePersonalState{}
class FailureEditGuidePersonalState extends EditGuidePersonalState{
  final String? errMessage;
  FailureEditGuidePersonalState({required this.errMessage});
}