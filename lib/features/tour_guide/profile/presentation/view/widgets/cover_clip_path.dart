import 'package:flutter/material.dart';

class CustomClipPath extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    double h=size.height;
    double w=size.width;
    final path=Path();
    path.moveTo(0, 0); //point ..1
    path.lineTo(0, h-h*0.25);//point  ..2
    path.quadraticBezierTo(w*0.5, h, w, h-h*0.25);
    path.lineTo(w, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper)=> false;
}