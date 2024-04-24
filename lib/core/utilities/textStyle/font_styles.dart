import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';

abstract class CustomTextStyle{
static const onBoardingTitle=TextStyle(color: Colors.white,fontSize: 48,fontWeight: FontWeight.bold,fontStyle: FontStyle.normal);
static const signINTitle=TextStyle(fontSize: 40, fontFamily: 'grover', fontWeight: FontWeight.bold,);
static const homePartTitle=TextStyle(fontSize: 30, fontFamily: 'grover', fontWeight: FontWeight.bold,);
static const homeEntityName=TextStyle(fontSize: 18, fontFamily: 'grover', fontWeight: FontWeight.bold,);
static const placesTitle=TextStyle(fontSize: 22, fontFamily: 'grover', fontWeight: FontWeight.bold,);
static const resetPassTitle=TextStyle(fontSize: 30, fontFamily: 'ABeeZee', fontWeight: FontWeight.bold,);
static const privateTourTitle=TextStyle(fontSize: 21, fontFamily: 'ABeeZee', fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis);
static const commonSignDark=TextStyle(fontSize: 16,fontWeight: FontWeight.bold,);
static const commonSignThinDark=TextStyle(fontSize: 16,);
static const commonFontThin=TextStyle(fontSize: 14,overflow: TextOverflow.ellipsis,);
static const commonFontThinNoOverFlow=TextStyle(fontSize: 14,);
static const commonFontThinLight=TextStyle(fontSize: 14,color: entertainmentColor,);
static const tripDetailsInTourGuide=TextStyle(fontSize: 12,overflow: TextOverflow.ellipsis);
static const commonProfileDark=TextStyle(fontSize: 14,fontWeight: FontWeight.bold,);
static const commonSignLight=TextStyle(fontSize: 16,color: entertainmentColor);
static const commonSignAlwaysWhite=TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white);
static const commonSignThinAlwaysWhite=TextStyle(fontSize: 16,color: Colors.white);
}