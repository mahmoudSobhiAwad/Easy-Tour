import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';

class SmallProfilePic extends StatelessWidget {
  const SmallProfilePic({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        backgroundColor: thirdColor,
        radius: width*0.06,
        child:Center(child: Image.asset('assets/login/default_profile.png',fit: BoxFit.fill,)));
  }
}