import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/place_destination.dart';

class TrendingDestinationInHotelBooking extends StatelessWidget {
  const TrendingDestinationInHotelBooking({super.key,required this.width,required this.height});
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Trending destinations',style: CustomTextStyle.privateTourTitle,),
        SizedBox(height: height*0.01,),
        Wrap(
          spacing:10,
          runSpacing:10,
          children: [
            ...List.generate(3, (index){
              return PlaceDestinationInHotelBooking(height: height, width: width,lastWidth:index==2? width:null,);
            }),
          ],
        ),
      ],
    );
  }
}