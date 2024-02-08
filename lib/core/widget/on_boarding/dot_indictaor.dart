import 'package:flutter/material.dart';

Widget dotIndicator(BuildContext context,int index,int currIndex){
  List<Color>onBoardingColor=const[
    Color(0xffF57366),
    Color(0xffFFAF4E),
    Color(0xff1F96B0),
  ];
  return Padding(
      padding:const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(10),
            color:currIndex==index ?onBoardingColor[index]:Colors.white,
            shape: BoxShape.rectangle,
        ),
        height:15,width: currIndex==index?50:20,),
  );
}