import 'package:flutter/material.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/views/widgets/one_review_for_one_trip.dart';
class ReviewListForHotelsOrRestaurants extends StatelessWidget {
  const ReviewListForHotelsOrRestaurants({super.key,required this.height,required this.width});
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        itemCount: 4,itemBuilder: (context,index)=>ItemReviewForOneTrip(width: width, height: height));
  }
}