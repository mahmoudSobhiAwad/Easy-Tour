import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
class ContainerBackIcons extends StatelessWidget {
  const ContainerBackIcons({
    super.key,
    required this.height,
    required this.width,
    required this.onPressed,
  });

  final double height;
  final double width;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height:height*0.07,
      width: width*0.2,
      decoration:const BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            offset: Offset(0,4),
          ),
        ],
        color: basicColor,
        borderRadius: BorderRadius.only(bottomRight:Radius.circular(20)),
      ),
      child: Center(
        child: IconButton(onPressed:onPressed,
            icon: const Icon(Icons.arrow_back_ios_new,color: Color(0xffFFFFFF),)),
      ),
    );
  }
}