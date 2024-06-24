import 'dart:io';
import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_app_bar_trip_generated.dart';
import 'package:prepare_project/features/tourist/image_classification/presentation/manager/image_classification_cubit.dart';
import 'package:prepare_project/features/tourist/image_classification/presentation/views/widgets/classify_with_camera.dart';
import 'package:prepare_project/features/tourist/image_classification/presentation/views/widgets/classify_with_qr_code.dart';
class ScannerWidget extends StatelessWidget {
  const ScannerWidget({super.key,required this.height,required this.width,required this.cubit});
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
          QrCodeScannerWidget(height: height, cubit: cubit, width: width),
          cubit.pickedFile==null?ImageWithCamera(height: height, width: width, cubit: cubit):
          Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.file(File(cubit.pickedFile!.path),fit: BoxFit.fill,width: width,height: height*0.5,),
            SizedBox(height: height*0.025,),
            CustomLoginButton(altWidth: width*0.4,borderRadius: 12,label: 'Get Data',enable: true,onTap: (){
              cubit.sendImageToClassify();
            },),
          ],
        ),
        ][cubit.currIndex]

      ],
    );
  }
}



