import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/function/service_locator.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_container.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_types.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/data/repo/get_all_tour_guide_trips_repo_imp.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/managers/tour_guide_trips_to_view_cubit.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/managers/tour_guide_trips_to_view_states.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/views/widgets/tour_guide_trips_for_tourist_body.dart';
class BookTripWithTourGuides extends StatelessWidget {
  const BookTripWithTourGuides({super.key});

  @override
  Widget build(BuildContext context) {
    final double height=BasicDimension.screenHeight(context);
    final double width=BasicDimension.screenWidth(context);
    return  BlocProvider(create: (context)=>TripsToViewCubit(tourGuideTripsForTouristRepoImp: getIt.get<TourGuideTripsForTouristRepoImp>())..getAllTrips(),
      child: BlocConsumer<TripsToViewCubit,TripsToViewStates>(builder: (context,state){
        var cubit=BlocProvider.of<TripsToViewCubit>(context);
        return Scaffold(
          body:cubit.isLoading?const Center(child: CircularProgressIndicator(color: basicColor,),):TourGuideTripForTouristList(height: height, width: width,tripList: cubit.tripList,),
        );
      }, listener: (context,state){
        if(state is FailureGetAllTripsToViewState){
          showDialog(context: context, builder: (context)=> ContainerAlertWidget(
            types: AlertTypes.failed,
            onTap: (){
              Navigator.pop(context);
            },
            content: '${state.errMessage}',));
        }
      }),
    );
  }
}








