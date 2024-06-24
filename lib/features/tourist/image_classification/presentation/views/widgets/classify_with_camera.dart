import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:prepare_project/features/tourist/image_classification/presentation/manager/image_classification_cubit.dart';
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