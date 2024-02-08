import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class LoginWithOption extends StatelessWidget {
  const LoginWithOption({super.key,required this.height,required this.width,this.text,this.icon,this.onTap,this.backGroundColor});
final String?text;
final FaIcon? icon;
final Color? backGroundColor;
final Future<void> Function()? onTap;
final double height;
final double width;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width*0.4,
        height: height*0.06,
        decoration: BoxDecoration(
          color: backGroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(20),
      ),),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
             icon!,
           const SizedBox(width: 2,),
            Text(text??"",style: const TextStyle(color: Colors.white),),
        ],
        ),
      ),
    );
  }
}