import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/manager/view_trip_details_cubit/view_trip_details_cubit.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/views/widgets/activity_deatils/activity_details_view.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/views/widgets/trip_details_widgets/activity_item_in_result_trip.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/views/widgets/trip_details_widgets/widgets_bar.dart';
class ActivityListWithBar extends StatelessWidget {
  const ActivityListWithBar({super.key,required this.height,required this.width,required this.cubit,required this.pageIndex});
  final double height;
  final double width;
  final ViewTripDetailsCubit cubit;
  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height*0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          ChangeShowForWidgetInGeneratedTrip(
              showDetails: true,
              height: height,barName: 'Activity'),
          const SizedBox(height: 10,),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context,index)
              {
                return GestureDetector(
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder:(context)=>ActivityDetailsView(place:cubit.generatedTripModel!.days[pageIndex].places[index],)));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: entertainmentColor,
                                child: Text('${index+1}'),
                              ),
                              SizedBox(
                                height: height*0.33,
                                child: const VerticalDivider(
                                  width: 2,
                                  color: entertainmentColor,
                                ),
                              ),
                              index+1== cubit.generatedTripModel!.days[pageIndex].places.length?const CircleAvatar(
                                backgroundColor: entertainmentColor,
                                child: Text('End'),
                              ):const SizedBox(),
                            ],
                          ),
                          SizedBox(width: width*0.05,),
                          OneActivityInGeneratedTrip(height: height, width: width,place: cubit.generatedTripModel!.days[pageIndex].places[index],),
                        ],
                      ));
                },
                separatorBuilder: (context,index)
                {
                  return  SizedBox(height: height*0.025,);
                },
                itemCount:cubit.generatedTripModel!.days[pageIndex].places.length,
            ),
          )
        ],
      ),
    );
  }
}