import 'package:flutter/material.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/manager/view_trip_details_cubit/view_trip_details_cubit.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/views/widgets/trip_details_widgets/activity_item_in_result_trip.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/views/widgets/trip_details_widgets/widgets_bar.dart';
class ActivityListWithBar extends StatelessWidget {
  const ActivityListWithBar({super.key,required this.height,required this.width,required this.cubit});
  final double height;
  final double width;
  final ViewTripDetailsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        ChangeShowForWidgetInGeneratedTrip(
            showDetails: cubit.showActivity,
            changeShow:(){
              cubit.changeShow('activity');
            }, height: height,barName: 'Activity'),
        const SizedBox(height: 10,),
        cubit.showActivity?
        SizedBox(
          height: height*0.33,
          child: ListView.separated(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context,index)
              {
                return OneActivityInGeneratedTrip(height: height, width: width);
              },
              separatorBuilder: (context,index)
              {
                return const SizedBox(height: 10,);
              },
              itemCount: 5
          ),
        ):
        const SizedBox(),
      ],
    );
  }
}