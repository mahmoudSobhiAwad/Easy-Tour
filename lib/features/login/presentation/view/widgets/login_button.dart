import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';

class CustomLoginButton extends StatelessWidget {
  const CustomLoginButton({super.key,this.altWidth,this.onTap,this.label,this.color,this.isLoading=false});
  final void Function()?onTap;
  final String?label;
  final Color? color;
  final bool isLoading;
  final double?altWidth;
  @override
  Widget build(BuildContext context) {
    final double height=BasicDimension.screenHeight(context);
    final double width=BasicDimension.screenWidth(context);
    return InkWell(
        onTap:onTap,
        child: Container(

          width:altWidth??width*0.4,
          height:height*0.055,
          decoration: BoxDecoration(
            boxShadow:const[
               BoxShadow(
              blurRadius: 4,
              offset: Offset(0, 4),
            )],
            borderRadius: const BorderRadius.all(
              Radius.circular(20),),color:color?? basicColor,),
          child: Center(
              child: isLoading? const CircularProgressIndicator(color: Colors.white,) :
              Text(label??"",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),)),));
  }
}

