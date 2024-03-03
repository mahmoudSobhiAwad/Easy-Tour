import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/model/generated_trip_model.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/views/widgets/trip_details_in_one_day.dart';
class StepperTripDay extends StatelessWidget {
  const StepperTripDay({super.key,required this.height,required this.width});
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height*.55,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Trip Day',style: CustomTextStyle.commonSignDark,),
          SizedBox(
            width: width,
            height: height*0.08,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ...List.generate(5, (index) {
                  return Row(
                    children: [
                      CircleAvatar(radius: width*0.075,backgroundColor: index==0?whatsAppColor:secondaryColor,child: Text('Day${index+1}',style: const TextStyle(color: Colors.white),),),
                      SizedBox(
                          width:width*0.1,
                          child: const Divider(thickness: 3,color: secondaryColor,)),
                    ],
                  );
                }
                ),
                CircleAvatar(backgroundColor: thirdColor,radius: width*0.075,child: const Text('End'),),
              ],
            ),
          ),
          SizedBox(
            height: height*0.4,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context,index) {
                  return OneTripPerDayItem(showLocation: false,bgColor: thirdColor,height: height, width: width, placeItem:const Place(name: 'Citadel of Salah-Elddin', longitude: 1547, latitude: 54464,
                      activity:'Discover the place there and enjoy with the atmosphere, Discover the place there and enjoy with the atmosphere, Discover the place there and enjoy with the atmosphere, Discover the place there and enjoy.',
                      category: 'Islamic Sites'));
                }
            ),
          )
        ],
      ),
    );
  }
}