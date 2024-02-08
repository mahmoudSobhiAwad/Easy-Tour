import 'package:flutter/material.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/tourist/image_classification/presentation/views/widgets/send_or_cancel_the_image.dart';

class OptionsAfterPickImage extends StatelessWidget {
  const OptionsAfterPickImage({
    super.key,
    required this.height,
    required this.width,
    required this.deleteImage,required this.isSent,required this.sentImage
  });

  final double height;
  final double width;
  final bool isSent;
  final void Function() deleteImage;
  final void Function() sentImage;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top:isSent?height*0.01:height*0.52,
      left: isSent?width*0.8:null,
      child:isSent?
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:commonBorderRadius(),
        ),
        child: Center(
          child: IconButton(onPressed: deleteImage, icon: const Icon(Icons.close)),
        ),
      ) :
      SendOrCancelImage(
          height: height, width: width, onCloseImage: deleteImage
          ,onSendImage: sentImage
      ),
    );
  }
}