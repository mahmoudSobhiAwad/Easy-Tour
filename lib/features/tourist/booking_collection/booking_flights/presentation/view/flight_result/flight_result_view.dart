import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/view/flight_result/flight_result_app_bar.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/view/flight_result/flight_result_list.dart';

class FlightResultView extends StatelessWidget {
  const FlightResultView({super.key});
  @override
  Widget build(BuildContext context) {
    final double height=BasicDimension.screenHeight(context);
    final double width=BasicDimension.screenWidth(context);
    return Scaffold(
      backgroundColor: const Color(0xffe7e7e7),
      body: SafeArea(
        child: Column(
          children: [
            FlightResultAppBar(height: height, width: width),
            FlightResultList(height: height, width: width),
          ],
        ),
      ),
    );
  }
}







