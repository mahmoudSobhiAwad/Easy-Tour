import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import '../../../../../../core/utilities/textStyle/font_styles.dart';
class CategoryOfTripHistoryTypes extends StatelessWidget {
  const CategoryOfTripHistoryTypes({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height*0.05,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 15),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Container(
              decoration: BoxDecoration(
                color: index==0?basicColor:thirdColor,
                borderRadius: BorderRadius.circular(14),
              ),
              padding:const EdgeInsets.all(8),
              child: Center(child: Text(tripTypes[index],style: CustomTextStyle.commonSignThinDark.copyWith(color: index==0?whiteColor:basicColor, ),)),
            ),
          );
        },
        itemCount: tripTypes.length,),
    );
  }
}

const List<String>tripTypes=['All','Custom Trips','Generated Trips With Ai','Trips With Tour Guide'];