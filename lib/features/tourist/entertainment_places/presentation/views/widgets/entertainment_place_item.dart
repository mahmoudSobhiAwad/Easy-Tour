import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/tourist_home/data/model/card_model.dart';
class EntertainmentPlaceItem extends StatelessWidget {
  const EntertainmentPlaceItem({super.key,required this.height,required this.cardModel});
  final double height;
  final CardModel cardModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 12,color: entertainmentColor)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:
        [
          Image.asset(cardModel.imagePath,height: height*0.12,),
          Text(cardModel.labelName,style: CustomTextStyle.homeEntityName.copyWith(fontSize: 14)),
        ],
      ),
    );
  }
}