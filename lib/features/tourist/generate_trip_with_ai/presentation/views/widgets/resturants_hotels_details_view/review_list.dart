import 'package:flutter/material.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/views/widgets/one_review_for_one_trip.dart';
import 'package:prepare_project/features/tourist/nearby_places/data/models/review_model.dart';
class ReviewListForHotelsOrRestaurants extends StatelessWidget {
  const ReviewListForHotelsOrRestaurants({super.key,required this.height,required this.width,required this.model});
  final double height;
  final double width;
  final List<ReviewModel> model;
  @override
  Widget build(BuildContext context) {
    return model.isEmpty?ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        itemCount: 4,itemBuilder: (context,index)=>ItemReviewForOneTrip(width: width, height: height, model: model[index],)) :
    const Text('No Review For That Place');
  }
}