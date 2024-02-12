import 'package:flutter/material.dart';

BorderRadius commonBorderRadius() =>const BorderRadius.only(topRight: Radius.circular(20),topLeft:Radius.circular(20),bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20) );
BoxShadow buildBoxShadow({Color? blurColor}) {

  return BoxShadow(
    color: blurColor??Colors.black.withOpacity(0.25),
    blurRadius: 2,
    offset:const Offset(0, 4),
  );
}