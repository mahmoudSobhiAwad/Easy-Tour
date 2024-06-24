import 'package:flutter/material.dart';
import 'package:prepare_project/features/tourist/image_classification/presentation/manager/image_classification_cubit.dart';
import 'package:prepare_project/features/tourist/image_classification/presentation/views/widgets/camer_and_flash_and_gallery.dart';
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
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(color: Colors.white,),
              height: height*0.8,
              width: width,
              child: QrScannerWidget(height: height,width: width, cubit:cubit),
            ),
            Spacer(),
            CameraFlashGallery(height: height, width: width, cubit: cubit),

          ],
        ),
      ),
    );
  }
}





