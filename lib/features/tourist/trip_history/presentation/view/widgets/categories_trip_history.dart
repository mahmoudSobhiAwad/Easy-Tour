import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import '../../../../../../core/utilities/textStyle/font_styles.dart';
class CategoryOfTripHistoryTypes extends StatelessWidget {
  const CategoryOfTripHistoryTypes({
    super.key,
    required this.height,
    required this.currIndex,
    required this.changeIndex,
  });

  final double height;
  final int currIndex;
  final void Function(int index) changeIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height*0.05,
      child: SingleChildScrollView(
        scrollDirection:Axis.horizontal,
        child: Row(
          children: [
            GestureDetector(
                onTap: (){
                  changeIndex(0);
                },
                child: OneBarItemInTripManager(currIndex: currIndex, index: 0, text: 'Generated Trips With Ai',)),
            GestureDetector(
                onTap: (){
                  changeIndex(1);
                },
                child: OneBarItemInTripManager(currIndex: currIndex, index: 1, text: 'Trips With Tour Guide',)),
            GestureDetector(
                onTap: (){
                  changeIndex(2);
                },
                child: OneBarItemInTripManager(currIndex: currIndex, index: 2, text: 'Custom Trips',)),
          ],
        ),
      ),
    );
  }
}

class OneBarItemInTripManager extends StatelessWidget {
  const OneBarItemInTripManager({
    super.key,
    required this.currIndex,
    required this.index,
    required this.text,
  });

  final int currIndex;
  final int index;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:8.0),
      child: Container(
        decoration: BoxDecoration(
          color: index==currIndex?basicColor:thirdColor,
          borderRadius: BorderRadius.circular(14),
        ),
        padding:const EdgeInsets.all(8),
        child: Center(child: Text(text,style: CustomTextStyle.fontNormal16.copyWith(color: index==currIndex?whiteColor:basicColor,),)),
              ),
    );
  }
}
