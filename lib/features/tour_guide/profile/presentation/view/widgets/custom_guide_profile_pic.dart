import 'dart:io';

import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/features/tour_guide/profile/presentation/view/widgets/cover_clip_path.dart';
import 'package:prepare_project/features/tourist/profile/presentation/views/widgets/pic_profile_widget.dart';

class ProfilePicWithClipper extends StatelessWidget {
  const ProfilePicWithClipper({
    super.key,
    required this.height,
    required this.width,
    required this.profileUrl,
    this.profileFile,
    this.enableEdit=false,
    this.editProfilePhoto,
  });
  final String? profileUrl;
  final File? profileFile;
  final double height;
  final double width;
  final bool enableEdit;
  final void Function()? editProfilePhoto;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ClipPath(
          clipper:CustomClipPath() ,
          child: Container(
            height: height*0.3,
            width: width,
            decoration: const BoxDecoration(
              color: thirdColor,
            ),
          ),
        ),
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            ProfilePicWidget(height: height*0.13, imageUrl: profileUrl,profileFile: profileFile,),
            enableEdit? GestureDetector(
                onTap: editProfilePhoto,
                child: CircleAvatar(radius: height*0.025,backgroundColor: Colors.white,child: Center(child: CircleAvatar(backgroundColor: thirdColor,radius: height*0.02,child:const Icon(Icons.edit,color: basicColor,),)),)) :
            const SizedBox(),
          ],
        ),

      ],
    );
  }
}