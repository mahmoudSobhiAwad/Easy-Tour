import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/features/tour_guide/private_tour/data/model/private_tour_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/managers/tour_guide_trips_to_view_cubit.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/managers/tour_guide_trips_to_view_states.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/views/widgets/show_trip_details_body.dart';
class ShowTourGuideTripsDetailsForTouristView extends StatelessWidget {
  const ShowTourGuideTripsDetailsForTouristView({super.key,required this.tripItem});
  final Trip tripItem;
  @override
  Widget build(BuildContext context) {
    final double height=BasicDimension.screenHeight(context);
    final double width=BasicDimension.screenWidth(context);
    return BlocProvider(
      create:(context)=>TripsToViewCubit(),
      child: BlocConsumer<TripsToViewCubit,TripsToViewStates>(builder: (context,state){
        var cubit=BlocProvider.of<TripsToViewCubit>(context);
        return Scaffold(
          body: ShowTourGuideTripsDetailsForTouristBody(height: height, width: width, tripItem: tripItem,cubit: cubit,),
        );
      }, listener:(context,state){

      })
    );
  }
}



