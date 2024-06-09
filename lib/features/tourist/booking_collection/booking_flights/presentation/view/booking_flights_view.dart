
import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/view/flight_request_body.dart';
import 'package:prepare_project/features/tourist/trip_history/presentation/view/widgets/intro_trip_history.dart';

class BookingFlightView extends StatelessWidget {
  const BookingFlightView({super.key});
  @override
  Widget build(BuildContext context) {
    final double width=BasicDimension.screenWidth(context);
    final double height=BasicDimension.screenHeight(context);
    return Scaffold(
      body: [
        CustomIntroScreen(mainTitle: 'Books Your Travel Ticket Easily and Safely', colorButton:ticketBasicColor,imagePath: 'assets/tourist_home/flight_intro.png', secondaryTitle: '', screenToGo: (){}),
        FlightRequestView(width: width, height: height)][1],
    );
  }
}










