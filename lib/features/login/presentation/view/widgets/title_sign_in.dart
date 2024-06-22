import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';

class TitleSignIn extends StatelessWidget {
  const TitleSignIn({
    super.key,
    required this.height,
    required this.width,

  });
final double height;
final double width;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomClipPath(),
      child: Container(
        padding: const EdgeInsets.only(left: 20,top: 40),
        alignment: Alignment.topLeft,
        height: height*0.35,
        width: width,
        decoration:const  BoxDecoration(
          boxShadow: [
             BoxShadow(
            blurRadius: 4,offset: Offset(0, 4)
          )],
          color: Color((0xff5F92D9))
        ),
        child:Text('Hi Welcome', style: CustomTextStyle.fontGrover40.copyWith(color: Colors.white),textAlign:TextAlign.start,),
      ),
    );
  }
}
class CustomClipPath extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    double h=size.height;
    double w=size.width;
    final path=Path();
    path.moveTo(0, 0); //point ..1
    path.lineTo(0, h-h*0.4);//point  ..2
    path.quadraticBezierTo(w*0.5, h, w, h-h*0.4);
    path.lineTo(w, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper)=> false;
}