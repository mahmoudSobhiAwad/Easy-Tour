import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/manager/generate_trip_cubit.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/views/widgets/add_new_destination.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/views/widgets/place_range_time_list.dart';
class PlacesWrapWidget extends StatelessWidget {
  const PlacesWrapWidget({
    super.key,
    required this.height,
    required this.width,
    required this.cubit
  });

  final double height;
  final double width;
  final GenerateAiTripCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width*0.025),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text('Select your Destinations ',style: CustomTextStyle.fontBold16,),
          Container(
            width: width,
            padding: const EdgeInsets.only(top: 10,bottom: 10),
            decoration: BoxDecoration(color: thirdColor,borderRadius: commonBorderRadius(),boxShadow: [buildBoxShadow()]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PlaceWithRangeTimeList(
                  height: height, width: width,
                  destinationList: cubit.destinationWithDayList,removeAt: (index){
                    cubit.decreaseDestinationWithDayList(index);
                  }, pickDate: (int index) {
                    cubit.getRangeDate(context,index);
                  }, onSelect: (String? value,int index) {
                    cubit.addToPlaces(value,index);
                  },),
                AddNewDestination(addNewDestination:(){cubit.increaseDestinationWithDayList();}, width: width),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



