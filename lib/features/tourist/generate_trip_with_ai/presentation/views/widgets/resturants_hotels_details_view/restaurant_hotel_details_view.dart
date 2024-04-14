import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/views/widgets/resturants_hotels_details_view/rest_or_hotel_details_body.dart';
class RestaurantOrHotelDetailsView extends StatelessWidget {
  const RestaurantOrHotelDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    double width=BasicDimension.screenWidth(context);
    double height=BasicDimension.screenHeight(context);
    return  Scaffold(
      body: RestaurantOrHotelDetailsBody(width: width, height: height),
    );
  }
}








