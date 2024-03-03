import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/views/widgets/tour_guide_trips_for_tourist_body.dart';
class BookTripWithTourGuides extends StatelessWidget {
  const BookTripWithTourGuides({super.key});

  @override
  Widget build(BuildContext context) {
    final double height=BasicDimension.screenHeight(context);
    final double width=BasicDimension.screenWidth(context);
    return  Scaffold(
      body: TourGuideTripForTouristList(height: height, width: width),
    );
  }
}








