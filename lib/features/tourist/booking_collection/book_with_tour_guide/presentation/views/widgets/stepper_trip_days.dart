import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tour_guide/private_tour/data/model/private_tour_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/managers/tour_guide_trips_to_view_cubit.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/model/generated_trip_model.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/views/widgets/trip_details_in_one_day.dart';
class StepperTripDay extends StatelessWidget {
  const StepperTripDay({super.key,required this.height,required this.width,required this.tripDays,required this.cubit});
  final double height;
  final double width;
  final List<TripDay>?tripDays;
  final TripsToViewCubit cubit;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height*.55,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Trip Days',style: CustomTextStyle.commonSignDark,),
          SizedBox(
            width: width,
            height: height*0.08,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ...List.generate(tripDays?.length??0, (index) {
                  return Row(
                    children: [
                      InkWell(
                          onTap:(){
                            cubit.goToSelectedDay(index);
                          },
                          child: CircleAvatar(radius: width*0.075,backgroundColor: index==cubit.currDay?whatsAppColor:secondaryColor,child: Text('Day${index+1}',style: const TextStyle(color: Colors.white),),)),
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
                itemCount: tripDays?[cubit.currDay].dayPlaces?.length,
                itemBuilder: (context,index) {
                  return OneTripPerDayItem(
                      showLocation: false,bgColor: thirdColor,height: height, width: width,
                      placeItem:Place(
                          name: tripDays?[cubit.currDay].dayPlaces?[index].placeName??"", longitude: 1547, latitude: 54464,
                          activity:tripDays?[cubit.currDay].dayPlaces?[index].activity??"",
                          category: tripDays?[cubit.currDay].dayPlaces?[index].placeType??""
                      ),
                  );
                }
            ),
          )
        ],
      ),
    );
  }
}