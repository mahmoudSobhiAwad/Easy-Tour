import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

const Color basicColor=Color(0xff1B2445);
const Color secondaryColor=Color(0xffa6a6a6);
const Color formFillColor=Color(0xffF5F6FF);
const Color thirdColor=Color(0xffEEEEEE);
const Color entertainmentColor=Color(0xff66757F);
const Color closeColor=Color(0xffAE0009);
const Color faceBookColor=Color(0xff1877F2);
const Color whatsAppColor=Color(0xff4BD37B);
class BasicDimension{
  static double screenHeight(BuildContext context){
    final size = MediaQuery.of(context).size;
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return size.height;
    } else {
      return size.width;
    }
  }
  static double screenWidth(BuildContext context){
    final size = MediaQuery.of(context).size;
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return size.width;
    } else {
      return size.height;
    }

  }

}
late List<CameraDescription> cameras;