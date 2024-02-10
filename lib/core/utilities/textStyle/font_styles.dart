import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';

abstract class CustomTextStyle{
static const onBoardingTitle=TextStyle(color: Colors.white,fontSize: 48,fontWeight: FontWeight.bold,fontStyle: FontStyle.normal);
static const signINTitle=TextStyle(color: basicColor, fontSize: 40, fontFamily: 'grover', fontWeight: FontWeight.bold,);
static const homePartTitle=TextStyle(color: basicColor, fontSize: 30, fontFamily: 'grover', fontWeight: FontWeight.bold,);
static const homeEntityName=TextStyle(color: basicColor, fontSize: 18, fontFamily: 'grover', fontWeight: FontWeight.bold,);
static const placesTitle=TextStyle(color: basicColor, fontSize: 22, fontFamily: 'grover', fontWeight: FontWeight.bold,);
static const resetPassTitle=TextStyle(color: basicColor, fontSize: 30, fontFamily: 'inter', fontWeight: FontWeight.bold,);
static const privateTourTitle=TextStyle(color: basicColor, fontSize: 21, fontFamily: 'inter', fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis);
static const commonSignDark=TextStyle(fontSize: 16,color: basicColor,fontWeight: FontWeight.bold,);
static const commonSignThinDark=TextStyle(fontSize: 16,color: basicColor,);
static const commonFontThin=TextStyle(fontSize: 14,color: basicColor,);
static const tripDetailsInTourGuide=TextStyle(fontSize: 12,color: basicColor,overflow: TextOverflow.ellipsis);
static const commonProfileDark=TextStyle(fontSize: 14,color: basicColor,fontWeight: FontWeight.bold,);
static const commonSignLight=TextStyle(fontSize: 16,color: entertainmentColor);
}