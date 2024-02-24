import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';

import '../../../data/model/type_of_places_toursim.dart';

class ListOfDaysOfTrip extends StatelessWidget {
  const ListOfDaysOfTrip({
    super.key,
    required this.height,
    required this.width,
    required this.currentDay,required this.controller,
    required this.tripDaysName,
  });

  final double height;
  final int currentDay;
  final ScrollController controller;
  final double width;
  final List<Day>tripDaysName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height*0.08,
        child: ListView.builder(
          controller: controller,
          itemCount: tripDaysName.length,
          padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context,index){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Text('Day ${index+1}',style: CustomTextStyle.placesTitle,),
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
            );
          },
        ));
  }
}