import 'dart:io';
import 'package:flutter/material.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/animated_switched_image.dart';

import '../../../../../core/utilities/basics.dart';

class VerificationIdWithAi extends StatelessWidget {
  const VerificationIdWithAi({super.key,this.imageId,required this.height,required this.tourGuidId,required this.imageTitle});
  final String?imageId;
  final double height;
  final String tourGuidId;
  final String imageTitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      height:height*.36,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: secondaryColor.withOpacity(0.5),),
          color: const Color(0xffF6F3F3)),
      child:imageId==null ? AnimatedSwitchImages(idImage: tourGuidId,imageTitle: imageTitle,):
      ClipRRect(
        borderRadius: BorderRadius.circular(20),
          child: Image.file(File(imageId!),fit: BoxFit.fill,)),
    );
  }
}

