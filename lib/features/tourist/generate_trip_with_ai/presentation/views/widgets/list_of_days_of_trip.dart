import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';

class ListOfDaysOfTrip extends StatelessWidget {
  const ListOfDaysOfTrip({
    super.key,
    required this.height,
    required this.width,
    required this.currentDay,required this.controller,
    required this.listOfDaysLength,
    required this.onTap,
  });

  final double height;
  final int currentDay;
  final ScrollController controller;
  final double width;
  final int listOfDaysLength;
  final void Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height*0.08,
        child: ListView.builder(
          controller: controller,
          itemCount: listOfDaysLength,
          padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context,index){
            return GestureDetector(
              onTap: (){
                onTap(index);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text('Day ${index+1}',style: CustomTextStyle.fontSecondaryBold22,),
                  ),
                  index==currentDay?
                  Container(
                    padding: EdgeInsets.zero,
                    width:width*0.16,
                    height:height*0.015,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: commonBorderRadius(),
                    ),):
                  const SizedBox(),
                ],
              ),
            );
          },
        ));
  }
}