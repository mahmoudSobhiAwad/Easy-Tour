import 'package:flutter/material.dart';

class TitleOfCreateAcc extends StatelessWidget {
  const TitleOfCreateAcc({super.key,this.textAlign,required this.mainStyle,required this.secondaryStyle,this.align,required this.mainText,required this.secondaryText,});
final CrossAxisAlignment? align;
final String mainText;
final String secondaryText;
final TextAlign? textAlign;
final TextStyle mainStyle;
final TextStyle secondaryStyle;
  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
       crossAxisAlignment:align??CrossAxisAlignment.center,
        children: [
          Text(mainText,style: mainStyle,textAlign: textAlign??TextAlign.center,),
          const SizedBox(height: 10,),
          Text(secondaryText,style:secondaryStyle,textAlign: textAlign??TextAlign.center,),
        ],
      ),
    );
  }
}