import 'dart:io';
import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
class ProfilePicWidget extends StatelessWidget {
  const ProfilePicWidget({
    super.key,
    required this.imageUrl,
    required this.height,

    this.profileFile,
  });

  final String? imageUrl;
  final double height;

  final File? profileFile;

  @override
  Widget build(BuildContext context) {
    return Container(
      height:height,
      width:height,
      decoration:  BoxDecoration(
        image:imageUrl!=''? DecorationImage(image:NetworkImage(imageUrl!),fit: BoxFit.fill)
            :const DecorationImage(image: AssetImage('assets/login/default_profile.png')),
        color: formFillColor,
        shape: BoxShape.circle,
      ),
      child:profileFile!=null?ClipOval(child: Image.file(profileFile!,fit: BoxFit.fill,)):null,
    );
  }
}