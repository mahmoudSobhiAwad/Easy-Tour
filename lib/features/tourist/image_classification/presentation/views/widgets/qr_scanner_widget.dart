import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_app_bar_trip_generated.dart';
import 'package:prepare_project/features/tourist/image_classification/presentation/manager/image_classification_cubit.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';
class QrScannerWidget extends StatelessWidget {
  const QrScannerWidget({super.key,required this.height,required this.width,required this.cubit});
  final double height;
  final double width;
  final ImageClassificationCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomGeneratedAiTripAppBar(height: height, width: width,appBarTitle: 'Image Identifier',),
        SizedBox(height: height*0.025,),
        DefaultTabController(
            length: 2,
            child: TabBar(
                onTap: (index){
                  cubit.changeCurrIndex(index);
                },
                tabs:[
                  Text('QR Code Scanner',style: CustomTextStyle.fontBold18,),
                  Text('Image Identifier',style: CustomTextStyle.fontBold18,),
        ])),
        SizedBox(height: height*0.025,),
        [
          Column(
          children: [
            SizedBox(
                height: height*0.4,
                child:MobileScanner(
                  controller:cubit.scannerController,
                  onDetect: (barCode){
                    cubit.isScanComplete(barcode: barCode);
                  },
                  overlay:cubit.image==null?
                  QRScannerOverlay(
                    scanAreaHeight: height*0.3,
                    scanAreaWidth: width*0.7,
                    borderColor:cubit.isScanned? whatsAppColor:basicColor,
                  ): Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: secondaryColor,borderRadius: BorderRadius.circular(20)),
                      child: Icon(Icons.qr_code_2_sharp,size: height*0.3,)),
                )
            ),
            SizedBox(height: height*0.025,),
            cubit.isScanned?
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomLoginButton(label: 'Get Data',enable: true,onTap: (){
                  cubit.getData();
                },),
              ],
            ) :
            const SizedBox(),
          ],
        ),
         cubit.pickedFile==null?ImageWithCamera(height: height, width: width, cubit: cubit):
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.file(File(cubit.pickedFile!.path),fit: BoxFit.fill,width: width,height: height*0.5,),
            SizedBox(height: height*0.025,),
            CustomLoginButton(altWidth: width*0.4,borderRadius: 12,label: 'Get Data',enable: true,),
          ],
        ),
        ][cubit.currIndex]

      ],
    );
  }
}

class ImageWithCamera extends StatelessWidget {
  const ImageWithCamera({
    super.key,
    required this.height,
    required this.width,
    required this.cubit,
  });

  final double height;
  final double width;
  final ImageClassificationCubit cubit;

  @override
  Widget build(BuildContext context) {
    int pointer=0;
    return SizedBox(
      height: height*.6,
      width: width,
      child: Listener(
         onPointerDown: (_) =>pointer++,
         onPointerUp: (_) =>pointer--,
        child: CameraPreview(
          cubit.cameraController,
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onScaleStart: cubit.handleScaleStart,
                  onScaleUpdate:cubit.handleScaleUpdate,
                  onTapDown: (TapDownDetails details) =>
                      cubit.onViewFinderTap(details, constraints),
                );
              }),
        ),
      ),
    );
  }
}