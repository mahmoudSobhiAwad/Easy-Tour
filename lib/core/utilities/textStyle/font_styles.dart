import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';

  abstract class CustomTextStyle{
  static const fontBold48=TextStyle(color: Colors.white,fontSize: 48,fontWeight: FontWeight.bold,fontStyle: FontStyle.normal);
  static var fontGrover40=TextStyle(fontSize: 40, fontFamily: 'grover', fontWeight: FontWeight.bold,);
  static var fontGrover30=TextStyle(fontSize: 30, fontFamily: 'grover', fontWeight: FontWeight.bold,);
  static var fontGrover18=TextStyle(fontSize: 18, fontFamily: 'grover', fontWeight: FontWeight.bold,);
  static var fontGrover22=TextStyle(fontSize: 22, fontFamily: 'grover', fontWeight: FontWeight.bold,);
  static TextStyle fontBold30=TextStyle(fontSize: 30,fontWeight: FontWeight.bold,);
  static TextStyle fontBold21=TextStyle(fontSize: 21, fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis);
  static TextStyle fontBold18=TextStyle(fontSize: 18, fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis);
  static TextStyle fontBold16=TextStyle(fontSize: 16,fontWeight: FontWeight.bold,);
  static TextStyle fontNormal16=TextStyle(fontSize: 16,);
  static TextStyle fontNormal14WithEllipsis=TextStyle(fontSize: 14,overflow: TextOverflow.ellipsis,);
  static TextStyle fontNormal14=TextStyle(fontSize: 14,);
  static TextStyle font14Light=TextStyle(fontSize: 14,color: entertainmentColor,);
  static const font12WithEllipsis=TextStyle(fontSize: 12,overflow: TextOverflow.ellipsis);
  static TextStyle fontBold14=TextStyle(fontSize: 14,fontWeight: FontWeight.bold,);
  static TextStyle font16Light=TextStyle(fontSize: 16,color: entertainmentColor);
  static TextStyle font16BoldWhite=TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white);
  static TextStyle font16NormalWhite=TextStyle(fontSize: 16,color: Colors.white);
  }