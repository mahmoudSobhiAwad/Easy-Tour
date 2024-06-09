import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/view/flight_details/ticket_info.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/view/flight_details/traveler_pricing_list.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/view/flight_result/flight_booking_ticket_item.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/view/flight_result/flight_result_app_bar.dart';

class FlightDetailsView extends StatelessWidget {
  const FlightDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final double width=BasicDimension.screenWidth(context);
    final double height=BasicDimension.screenHeight(context);
    return Scaffold(
      body: SafeArea(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height:height*0.25,
                    child: ColoredBox(
                      color: ticketBasicColor,
                      child: Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0,top: 8),
                            child: CustomFlightTicketingAppBar(width: width,title: 'Flight Details',),
                          )),),
              ),
                  SizedBox(
                    height: height*0.15,
                  ),
                  const TicketInfo(),
                  TravelerPricingList(height: height, width: width),
                ],
              ),
              Positioned(
                  top: height*0.08,
                  left: width*0.1,
                  child: FlightTicketItem(width: width, height: height)),
              
            ],
          )),
    );
  }
}








