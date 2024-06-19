import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/manager/get_ticket/cubit.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/view/departure_return_date.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/view/flight_result/flight_result_view.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/view/intro_flight_request.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/view/origin_departure_place.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/view/traveler_num_trip_type.dart';
class FlightRequestView extends StatelessWidget {
  const FlightRequestView({super.key,required this.width,required this.height,required this.cubit});
  final double width;
  final double height;
  final GetTicketCubit cubit;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          IntroInFlightBooking(height: height),
          Positioned(
            top: height*0.22,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(10),
                height: height*0.75,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
                ),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OriginAndDeparturePlace(width: width,cubit: cubit,height: height,),
                    SizedBox(height: height*0.02,),
                    DepartureAndReturnDate(width: width, height: height),
                    SizedBox(height: height*0.02,),
                    TravelersDateAndTripType(width: width, height: height),
                    SizedBox(height: height*0.033,),
                    Center(
                      child: CustomLoginButton(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const FlightResultView()));
                        },
                        color: ticketBasicColor,
                        altWidth: width*0.7,
                        borderRadius: 12,

                        label: 'Search For Flights',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
