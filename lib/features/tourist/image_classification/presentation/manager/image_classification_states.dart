abstract class ImageClassificationStates {}
class InitialImageClassificationState extends ImageClassificationStates {}
class SuccessInitialImageClassificationState extends ImageClassificationStates {}
class FailedInitialImageClassificationState extends ImageClassificationStates {
  final String? errMessage;
  FailedInitialImageClassificationState({this.errMessage});
}
class SuccessPickImageClassificationState extends ImageClassificationStates {}
class FailedPickedImageClassificationState extends ImageClassificationStates {
  final String?errMessage;
  FailedPickedImageClassificationState({this.errMessage});
}
class DeletePickedImage extends ImageClassificationStates {}
class LoadingGetImageInfoClassificationState extends ImageClassificationStates {}
class SuccessGetImageInfoClassificationState extends ImageClassificationStates {}
class FailedGetImageInfoClassificationState extends ImageClassificationStates {
  final String?errMessage;
  FailedGetImageInfoClassificationState({this.errMessage});
}
class SuccessChangeCameraFlashMode extends ImageClassificationStates {}
class ChangeFlashIndex extends ImageClassificationStates {}


