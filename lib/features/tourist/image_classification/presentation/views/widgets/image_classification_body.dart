import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:prepare_project/features/tourist/image_classification/presentation/manager/image_classification_cubit.dart';
import 'package:prepare_project/features/tourist/image_classification/presentation/views/widgets/after_pick_image_options.dart';
import 'package:prepare_project/features/tourist/image_classification/presentation/views/widgets/camer_and_flash_and_gallery.dart';
import 'package:prepare_project/features/tourist/image_classification/presentation/views/widgets/container_back_icon.dart';
import 'package:prepare_project/features/tourist/image_classification/presentation/views/widgets/image_classify_info.dart';

class ImageClassificationBody extends StatelessWidget {
  const ImageClassificationBody({
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top:30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(borderRadius: BorderRadius.only(bottomRight:Radius.circular(20) ,bottomLeft: Radius.circular(20))),
                  height: height*0.6,
                  width: width,
                  child:cubit.pickedImage==null ?CameraPreview(cubit.cameraController):Image.file(File(cubit.pickedImage!.path),fit: BoxFit.fill,),
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: ContainerBackIcons(height: height, width: width,
                      onPressed: (){
                      cubit.dispose().then((value)
                      {
                        Navigator.pop(context);
                      }
                      );
                      },
                    ),
                ),
                cubit.pickedImage==null?
                CameraFlashGallery(height: height, width: width, cubit: cubit):
                OptionsAfterPickImage(
                    height: height,
                    width: width, deleteImage: () {
                      cubit.deletePickedImage();
                }, isSent: cubit.isSent, sentImage: () {
                      cubit.sentImage();
                },
                ),
              ],
            ),
            const Expanded(child: SizedBox(height: 10,)),
            ImageClassificationInfo(height: height, width: width,isVisible: cubit.isVisible,),
          ],
        ),
      ),
    );
  }
}






