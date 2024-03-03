import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/views/widgets/show_trip_details_body.dart';
class ShowTourGuideTripsDetailsForTouristView extends StatelessWidget {
  const ShowTourGuideTripsDetailsForTouristView({super.key});
  @override
  Widget build(BuildContext context) {
    final double height=BasicDimension.screenHeight(context);
    final double width=BasicDimension.screenWidth(context);
    return Scaffold(
      body: ShowTourGuideTripsDetailsForTouristBody(height: height, width: width),
    );
  }
}



