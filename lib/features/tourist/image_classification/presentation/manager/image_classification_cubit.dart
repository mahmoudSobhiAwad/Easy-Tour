import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/features/tourist/image_classification/data/models/qr_scanned_model.dart';
import 'package:prepare_project/features/tourist/image_classification/data/repos/qr_scanned_repo.dart';
import 'package:prepare_project/features/tourist/image_classification/presentation/manager/image_classification_states.dart';

class ImageClassificationCubit extends Cubit<ImageClassificationStates>{
  ImageClassificationCubit({required this.qrScannedRepo}):super(InitialImageClassificationState());
  bool isScanned=false;
  MobileScannerController scannerController = MobileScannerController(returnImage: true,autoStart:false);
  String?code;
  final QrScannedRepo qrScannedRepo;
  FlashMode currentFlashMode=FlashMode.auto;
  Uint8List?image;
  bool isLoading=false;
  bool isFinished=false;
  int currIndex=0;
  int pointer=0;
  XFile?pickedFile;
  ImagePicker imagePicker=ImagePicker();
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 1.0;
  double _currentScale = 1.0;
  double _baseScale = 1.0;
  late CameraController cameraController;
  void startScanner(){
    scannerController.start();
    emit(InitialStartScanner());
  }

  void clearImage()async{
    if(pickedFile!=null&&currIndex==1){
      pickedFile=null;
      emit(DeletePickedImage());
    }
    else if(isScanned&&currIndex==0){
      isScanned=false;
      code='';
      image=null;
      await scannerController.start();
      emit(DeletePickedImage());
    }
    }
    void finishWrite(){
    isFinished=true;
    emit(ShowButtonShowMoreToChatBot());
    }
  void isScanComplete({required BarcodeCapture barcode})async{
    if(!isScanned){
    isScanned = true;
    code = barcode.barcodes.first.rawValue?? "---";
    image=barcode.image;
    emit(SuccessScannedQrCodeState());
    await scannerController.stop();
    }
  }
  Future<void> getData() async {
    var data = json.encode({
      "text": "$code"
    });
    isLoading=true;
    emit(LoadingGetImageInfoClassificationState());
    var result=await qrScannedRepo.sendScannedQr(data:data);
    result.fold((l){
      isLoading=false;
      emit(FailedGetImageInfoClassificationState(errMessage:l.errMessage));
    }, (r){
      isLoading=false;
      emit(SuccessGetImageInfoClassificationState(model:r));
    });
  }
  void changeCurrIndex(int index)async{
    currIndex=index;
    emit(ChangeBetweenQrCodeAndCamera());
    if(currIndex==1){
      await initCamera();
    }
    emit(ChangeBetweenQrCodeAndCamera());
  }
  Future<void> initCamera()async{
    cameraController=CameraController(cameras.first, ResolutionPreset.high);
    await cameraController.initialize();
    await Future.wait(<Future<Object?>>[
      // The exposure mode is currently not supported on the web.
      cameraController
          .getMaxZoomLevel()
          .then((double value) => _maxAvailableZoom = value),
      cameraController
          .getMinZoomLevel()
          .then((double value) => _minAvailableZoom = value),
    ]);
    emit(InitCameraSuccessState());
  }
  void handleScaleStart(ScaleStartDetails details) {

    _baseScale = _currentScale;
    emit(ChangePointerValueState());
  }

  Future<void> handleScaleUpdate(ScaleUpdateDetails details) async {
    // When there are not exactly two fingers on screen don't scale
    if (pointer != 2) {
      return;
    }

    _currentScale = (_baseScale * details.scale)
        .clamp(_minAvailableZoom, _maxAvailableZoom);

    await cameraController.setZoomLevel(_currentScale);
    emit(ChangePointerValueState());
  }

  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    final CameraController cameraControl = cameraController;

    final Offset offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );
    cameraControl.setExposurePoint(offset);
    cameraControl.setFocusPoint(offset);
    emit(ChangePointerValueState());
  }

  Future<void> takePicture() async {
    if (cameraController.value.isTakingPicture) {
      return null;
    }
    try {
      pickedFile = await cameraController.takePicture();
      emit(PickImageSuccessState());
    } on CameraException catch (e) {
      emit(FailureTakePicture(errMessage:e.toString()));
    }
  }

  Future<void>pickFromGallery()async{
    imagePicker.pickImage(source: ImageSource.gallery).then((value) {
      if(value!=null){
        pickedFile=value;
        emit(PickImageSuccessState());
      }
    });
  }

  Future<void>sendImageToClassify()async{
    FormData formData = FormData.fromMap({
     if(pickedFile!=null) 'image':[await MultipartFile.fromFile(pickedFile!.path)],
    });
    emit(LoadingSendImageToClassify());
    isLoading=true;
    var result=await qrScannedRepo.sendImageToClassify(data: formData);
    result.fold((failure) {
      isLoading=false;
      emit(FailureSendImageToClassify(errMessage: failure.errMessage));
    }, (success) {
      isLoading=false;
      emit(SuccessSendImageToClassify(model: QrScannedModel(imageUrl: ImagePathWithType(type: imageType.local,image: pickedFile!.path),rawDate: success)));
    });

  }
}

