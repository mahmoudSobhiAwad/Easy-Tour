import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/login_sign_up/create_acc_title.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
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
        const TitleOfCreateAcc(mainStyle: CustomTextStyle.homePartTitle,
            secondaryStyle: CustomTextStyle.fontBold21,
            maxLines: 2,
            mainText: 'Optical Scanner ',
            secondaryText: 'Scan Qr Code To Discover the monument With Details'),
        SizedBox(height: height*0.05,),
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
        SizedBox(height: height*0.05,),
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