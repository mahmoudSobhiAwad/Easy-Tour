import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
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
  void startScanner(){
    scannerController.start();
    emit(InitialStartScanner());
  }
  void clearImage()async{
    if(isScanned){
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

}
