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


