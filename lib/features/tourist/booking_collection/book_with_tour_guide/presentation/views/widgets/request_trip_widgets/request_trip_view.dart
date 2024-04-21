import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/function/service_locator.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_container.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_types.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/data/repo/book_request_with_guide/request_to_book_trip_repo_imp.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/managers/request_trip_cubit/request_trip_cubit.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/managers/request_trip_cubit/request_trip_states.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/views/widgets/request_trip_widgets/widgets/request_trip_body.dart';

class RequestTripView extends StatelessWidget {
  const RequestTripView({super.key,required this.tripId,this.tripTicket,required this.tripDays});
  final String tripId;
  final String? tripDays;
  final Map<String,dynamic>?tripTicket;
  @override
  Widget build(BuildContext context) {
    final double height=BasicDimension.screenHeight(context);
    final double width=BasicDimension.screenWidth(context);
    return  BlocProvider(
      create:(context)=>BookTripWithTGCubit(tripId:tripId,tripTicket:tripTicket,requestToBookTrip: getIt.get<RequestToBookTripWithGuideRepoImp>())..initPrice(),
      child: BlocConsumer<BookTripWithTGCubit,BookTripWithTGStates>(
          builder: (context,state)
          {
            var cubit=BlocProvider.of<BookTripWithTGCubit>(context);
            return Scaffold(
              body: RequestTripToBookBody(width: width, height: height,cubit:cubit,tripDays: tripDays,),
      );
            },
          listener: (context,state){
            if(state is FailureSendRequestToBookTrip){
              showDialog(context: context, builder: (context)=> ContainerAlertWidget(
                types: AlertTypes.failed,
                onTap: (){
                  Navigator.pop(context);
                },
                content: '${state.errMessage}',));
            }
            else if(state is SuccessSendRequestToBookTrip){
              showDialog(context: context, builder: (context)=> ContainerAlertWidget(
                types: AlertTypes.success,
                onTap: (){
                  context.pop();
                  context.pop();
                },
                content: 'Sent Request Success',));

            }
          }),);
  }
}


