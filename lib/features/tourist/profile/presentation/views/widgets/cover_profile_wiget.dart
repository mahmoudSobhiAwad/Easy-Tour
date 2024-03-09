import 'dart:io';

import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/constant_var/constant.dart';
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
        image:coverUrl!=''? DecorationImage(image: NetworkImage(coverUrl!),fit: BoxFit.fill):const DecorationImage(image: NetworkImage(defaultCoverTrip,),fit: BoxFit.fill),
        color: secondaryColor,
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight:Radius.circular(15) ),
      ),
      child:coverFile !=null ?ClipRRect(borderRadius: BorderRadius.circular(15), child: Image.file(coverFile!,fit: BoxFit.fill,),):null,
    );
  }
}