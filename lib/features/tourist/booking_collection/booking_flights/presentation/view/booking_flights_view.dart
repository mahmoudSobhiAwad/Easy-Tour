
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/function/service_locator.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_container.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_types.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/data/flight_repos/get_tickets_repo_impl.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/manager/get_ticket/cubit.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/manager/get_ticket/states.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/view/flight_request_body.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/view/flight_result/flight_result_view.dart';
import 'package:prepare_project/features/tourist/trip_history/presentation/view/widgets/intro_trip_history.dart';

class BookingFlightView extends StatelessWidget {
  const BookingFlightView({super.key});
  @override
  Widget build(BuildContext context) {
    final double width=BasicDimension.screenWidth(context);
    final double height=BasicDimension.screenHeight(context);
    return BlocProvider(
      create: (context)=>GetTicketCubit(getTicketsRepoImpl: getIt.get<GetTicketsRepoImpl>())..getAccessToken(),
      child: BlocConsumer<GetTicketCubit,GetTicketsStates>(
          builder: (context,state){
            var cubit=BlocProvider.of<GetTicketCubit>(context);
            return Scaffold(
              body: [
                CustomIntroScreen(mainTitle: 'Books Your Travel Ticket Easily and Safely', colorButton:ticketBasicColor,imagePath: 'assets/tourist_home/flight_intro.png', secondaryTitle: '', screenToGo: (){}),
                FlightRequestView(width: width, height: height,cubit: cubit,)][1],
            );
          },
          listener: (context,state){
            var cubit=BlocProvider.of<GetTicketCubit>(context);

            if(state is SuccessGetTicketsState){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>FlightResultView(ticketsList: state.ticketsList, origin: cubit.fromPlace!,dest: cubit.toPlace!,travelerNum: cubit.childNum+cubit.adultNum,)));
            }
            else if(state is FailureGetTicketsState){
              showDialog(context: context, builder: (context)=> ContainerAlertWidget(
                types: AlertTypes.failed,
                onTap: (){
                  Navigator.pop(context);
                },
                content: '${state.errMessage}',));
            }
          }),);
  }
}










