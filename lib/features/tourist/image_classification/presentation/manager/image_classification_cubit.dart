import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/features/tourist/image_classification/presentation/manager/image_classification_states.dart';

class ImageClassificationCubit extends Cubit<ImageClassificationStates>{
  ImageClassificationCubit():super(InitialImageClassificationState());
  XFile? pickedImage;
  bool isSent=false;
  int flashIndex=0;
  ImagePicker imagePicker=ImagePicker();
  late CameraController cameraController;
  bool isVisible=false;
  FlashMode currentFlashMode=FlashMode.auto;
  void initCameraController(){
    cameraController = CameraController(cameras[0], ResolutionPreset.max);
    cameraController.initialize().then((_) {
      emit(SuccessInitialImageClassificationState());
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            emit(FailedInitialImageClassificationState(errMessage:'Camera Access Denied'));
            break;
          default:
            emit(FailedInitialImageClassificationState(errMessage:e.code));
            break;
        }
      }
    });
  }
  void changeFlashModel(){
    cameraController.setFlashMode(FlashMode.values[getFlashIndex()]);
    currentFlashMode=cameraController.value.flashMode;
    emit(SuccessChangeCameraFlashMode());
  }
  int getFlashIndex(){
    if(flashIndex<3){
      flashIndex++;
    }
    else{
      flashIndex=0;
    }
    emit(ChangeFlashIndex());
    return flashIndex;
  }
  Future<void> dispose()async{
   await cameraController.dispose();
  }
  Future<void> takePicture() async {
    isSent=false;
    if (!cameraController.value.isInitialized) {
     emit(FailedPickedImageClassificationState(errMessage: 'Camera Is Not Initialized'));
    }

    if (cameraController.value.isTakingPicture) {}

    try {
     pickedImage = await cameraController.takePicture();
     emit(SuccessPickImageClassificationState());

    } on CameraException catch (e) {
      emit(FailedPickedImageClassificationState(errMessage: e.description));
    }
  }
  void deletePickedImage(){
    pickedImage=null;
    emit(DeletePickedImage());
  }
  void sentImage(){
    isVisible=true;
    isSent=true;
    emit(SuccessGetImageInfoClassificationState());
  }
  Future<void>getImageFromGallery()async{
    pickedImage=await imagePicker.pickImage(source: ImageSource.gallery);
    if(pickedImage!=null){
      emit(SuccessPickImageClassificationState());
    }
  }
  IconData getFlashIcon(FlashMode currentFlashMode) {
    switch (currentFlashMode) {
      case FlashMode.auto:
        return Icons.flash_auto;
      case FlashMode.off:
        return Icons.flash_off;
      case FlashMode.torch:
        return Icons.flashlight_on;
      case FlashMode.always:
        return Icons.flash_on;
    }
  }
}
