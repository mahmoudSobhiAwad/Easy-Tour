import 'dart:io';

import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
class CoverPictureWidget extends StatelessWidget {
  const CoverPictureWidget({
    super.key,
    required this.widgetHeight,
    required this.widgetWidth,
    required this.coverUrl,
    this.coverFile,
  });
  final String?coverUrl;
  final double widgetHeight;
  final double? widgetWidth;
  final File? coverFile;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widgetHeight,
      width: widgetWidth,
      decoration: BoxDecoration(
        image:coverUrl!=null? DecorationImage(image: NetworkImage(coverUrl!),fit: BoxFit.fill):const DecorationImage(image: AssetImage('assets/login/default_cover.png',),fit: BoxFit.fill),
        color: secondaryColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child:coverFile !=null ?ClipRRect(borderRadius: BorderRadius.circular(15), child: Image.file(coverFile!,fit: BoxFit.fill,),):null,
    );
  }
}