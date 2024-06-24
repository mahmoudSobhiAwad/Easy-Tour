import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/features/tourist/image_classification/presentation/manager/image_classification_cubit.dart';

class CameraFlashGallery extends StatelessWidget {
  const CameraFlashGallery({
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
    return Container(
      height: height*0.11,
      padding:const EdgeInsets.all(15),
      decoration:const BoxDecoration(
        color: thirdColor,
        borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30),),
      ),
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          cubit.currIndex==1?
          IconButton(onPressed:(){cubit.pickFromGallery();}, icon:  Icon(Icons.image)):
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cubit.scannerController.torchState,
              builder: (context, state, child) {
                switch (state) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: basicColor);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: basicColor);
                }
              },
            ),
            iconSize: 40.0,
            onPressed: () => cubit.scannerController.toggleTorch(),
          ),
          Container(
              padding:const EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black, // Adjust border color
                  width: 3, // Adjust border width
                ),
              ),
              child:cubit.currIndex==1?IconButton(onPressed: (){cubit.takePicture();}, icon: Icon(Icons.photo_camera)):IconButton(
                color: Colors.white,
                icon: ValueListenableBuilder(
                  valueListenable: cubit.scannerController.cameraFacingState,
                  builder: (context, state, child) {
                    switch (state) {
                      case CameraFacing.front:
                        return const Icon(Icons.cameraswitch_rounded,color: basicColor,);
                      case CameraFacing.back:
                        return const Icon(Icons.cameraswitch_rounded,color: basicColor,);
                    }
                  },
                ),
                iconSize: height*0.045,
                onPressed: () => cubit.scannerController.switchCamera(),
              ),
          ),
          IconButton(
              tooltip: 'Gallery',
              onPressed: (){
                cubit.clearImage();
              },
              icon:const Icon(Icons.delete,size: 40,color: Colors.black,))
        ],
      ),
    );
  }
}