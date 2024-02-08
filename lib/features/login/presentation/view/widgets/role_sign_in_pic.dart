
import 'package:flutter/material.dart';
import 'package:prepare_project/features/login/data/image_data.dart';
class RoleSignInPic extends StatelessWidget {
  const RoleSignInPic({super.key,this.toggleRole,required this.width,required this.height});
  final int ?toggleRole;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: height*0.2,
      width: width*0.75,
      decoration:  BoxDecoration(
          shape: BoxShape.rectangle,
          image: DecorationImage(image: AssetImage(imageRole[toggleRole??0],),)),
    );
        }
}
