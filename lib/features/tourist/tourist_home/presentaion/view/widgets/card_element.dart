import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/tourist_home/data/model/card_model.dart';

class CardElement extends StatelessWidget {
  const CardElement({super.key,required this.height,required this.width,required this.cardModel});
  final double height;
  final double width;
  final CardModel? cardModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width*0.37,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.75),
              blurRadius: 4,
              spreadRadius:0,
              offset:const Offset(4,8),
            ),]
      ),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image(image: AssetImage(cardModel!.imagePath,),fit: BoxFit.fitWidth,height: height*0.14,),
          Text(cardModel!.labelName,style: CustomTextStyle.homeEntityName,overflow: TextOverflow.ellipsis,),
        ],
      ),
    );
  }
}