import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:prepare_project/features/tourist/image_classification/presentation/manager/image_classification_states.dart';

class ImageClassificationCubit extends Cubit<ImageClassificationStates>{
  ImageClassificationCubit():super(InitialImageClassificationState());
  bool isScanned=false;
  MobileScannerController scannerController = MobileScannerController(returnImage: true,);
  String?code;
  FlashMode currentFlashMode=FlashMode.auto;
  Uint8List?image;
  void clearImage()async{
    if(isScanned){
    isScanned=false;
    code='';
    image=null;
    await scannerController.start();
    emit(DeletePickedImage());
    }
  }
  void isScanComplete({required BarcodeCapture barcode})async{
    if(!isScanned){
    isScanned = true;
    code = barcode.barcodes.first.rawValue?? "---";
    image=barcode.image;
    emit(SuccessGetImageInfoClassificationState());
    await scannerController.stop();
    }
  }

}
