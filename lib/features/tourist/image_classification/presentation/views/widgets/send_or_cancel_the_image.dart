import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:flutter/material.dart';
class SendOrCancelImage extends StatelessWidget {
  const SendOrCancelImage({super.key,required this.height,required this.width,required this.onCloseImage,this.onSendImage});
  final double height;
  final double width;
  final void Function()?onSendImage;
  final void Function()?onCloseImage;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 20,),
          GestureDetector(
            onTap: onSendImage,
            child: Container(
              height: height*0.05,
              width: width*0.15,
              decoration: BoxDecoration(
                color: thirdColor,
                borderRadius: commonBorderRadius(),
              ),
              child:const Center(child: Icon(Icons.check,size: 33,color: basicColor,)),
            ),
          ),
          GestureDetector(
            onTap: onCloseImage,
            child: Container(
              height: height*0.05,
              width: width*0.15,
              decoration: BoxDecoration(
                color: thirdColor,
                borderRadius: commonBorderRadius(),
              ),
              child:const Center(child: Icon(Icons.close,size: 33,color: basicColor,)),
            ),
          ),
          const SizedBox(width: 20,),
        ],
      ),
    );
  }
}