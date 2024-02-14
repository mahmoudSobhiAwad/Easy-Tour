import 'package:flutter/material.dart';

class CustomClipPathForNextTrip extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    double h=size.height;
    double w=size.width;
    final path=Path();
    path.moveTo(w, 0);
    path.lineTo(w, h);
    path.lineTo(w-w*0.9 ,h);
    //path.lineTo(w, h-h*0.15);
    path.quadraticBezierTo(w-w*0.9, h-h*0.15,w,h-h*0.15);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }

}
class CustomClipPathForPervTrip extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    double h=size.height;
    double w=size.width;
    final path=Path();
    path.moveTo(0, 0);
    path.lineTo(0, h);
    path.lineTo(w, h);
    path.quadraticBezierTo(w-w*0.1, h-h*0.15,0,h-h*0.15);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }

}