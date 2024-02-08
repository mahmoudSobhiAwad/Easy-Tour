import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:prepare_project/core/utilities/basics.dart';
Future<CroppedFile?> getImageCropped(String sourcePath) {
  return ImageCropper().cropImage(
    sourcePath: sourcePath,
    aspectRatioPresets: [
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio16x9
    ],
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: 'Edit Photo',
        toolbarColor:Colors.white,
        toolbarWidgetColor: basicColor,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      ),
      IOSUiSettings(
        title: 'Cropper',
      ),
    ],
  );
}