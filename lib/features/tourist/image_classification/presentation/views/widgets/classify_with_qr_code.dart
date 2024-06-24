import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
import 'package:prepare_project/features/tourist/image_classification/presentation/manager/image_classification_cubit.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';
class QrCodeScannerWidget extends StatelessWidget {
  const QrCodeScannerWidget({
    super.key,
    required this.height,
    required this.cubit,
    required this.width,
  });

  final double height;
  final ImageClassificationCubit cubit;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}