import 'package:flutter/material.dart';
import 'package:prepare_project/features/tourist/image_classification/presentation/manager/image_classification_cubit.dart';
import 'package:prepare_project/features/tourist/image_classification/presentation/views/widgets/camer_and_flash_and_gallery.dart';
import 'package:prepare_project/features/tourist/image_classification/presentation/views/widgets/container_back_icon.dart';
import 'package:prepare_project/features/tourist/image_classification/presentation/views/widgets/qr_scanner_widget.dart';

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                padding: EdgeInsets.only(top: height*0.1),
                decoration: const BoxDecoration(color: Colors.white,),
                height: height,
                width: width,
                child: QrScannerWidget(height: height,width: width, cubit:cubit),
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0,),
                    child: ContainerBackIcons(height: height, width: width,
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                  ),
              ),
              CameraFlashGallery(height: height, width: width, cubit: cubit),
            ],
          ),

        ],
      ),
    );
  }
}





