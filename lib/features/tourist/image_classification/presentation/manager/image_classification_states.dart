import 'package:prepare_project/features/tourist/image_classification/data/models/qr_scanned_model.dart';

abstract class ImageClassificationStates {}
class InitialImageClassificationState extends ImageClassificationStates {}
class InitialStartScanner extends ImageClassificationStates {}
class DeletePickedImage extends ImageClassificationStates {}
class LoadingGetImageInfoClassificationState extends ImageClassificationStates {}
class SuccessGetImageInfoClassificationState extends ImageClassificationStates {
  final QrScannedModel model;
  SuccessGetImageInfoClassificationState({required this.model});
}
class SuccessScannedQrCodeState extends ImageClassificationStates {}
class FailedGetImageInfoClassificationState extends ImageClassificationStates {
  final String?errMessage;
  FailedGetImageInfoClassificationState({this.errMessage});
}
class SuccessChangeCameraFlashMode extends ImageClassificationStates {}
class ChangeFlashIndex extends ImageClassificationStates {}

class ShowButtonShowMoreToChatBot extends ImageClassificationStates {}

class ChangeBetweenQrCodeAndCamera extends ImageClassificationStates {}

class InitCameraSuccessState extends ImageClassificationStates {}

class ChangePointerValueState extends ImageClassificationStates {}

class PickImageSuccessState extends ImageClassificationStates {}

class FailureTakePicture extends ImageClassificationStates {
  final String?errMessage;
  FailureTakePicture({this.errMessage});
}

class FailureSendImageToClassify extends ImageClassificationStates {
  final String?errMessage;
  FailureSendImageToClassify({this.errMessage});
}
class LoadingSendImageToClassify extends ImageClassificationStates {}

class SuccessSendImageToClassify extends ImageClassificationStates {
  final QrScannedModel model;
  SuccessSendImageToClassify({required this.model});
}


