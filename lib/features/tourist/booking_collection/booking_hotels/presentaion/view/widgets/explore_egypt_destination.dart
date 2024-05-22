import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/place_destination.dart';
class ExploreEgyptDestination extends StatelessWidget {
  const ExploreEgyptDestination({super.key,required this.height,required this.width});
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Explore Egypt',style: CustomTextStyle.privateTourTitle,),
        SizedBox(height: height*0.01,),
        SizedBox(
          height: height*0.15,
          child: ListView.separated(
            itemBuilder: (context,index){
              return PlaceDestinationInHotelBooking(height: height, width: width);
            },
            separatorBuilder: (context,index){
              return SizedBox(width: width*0.025,);
            }, itemCount: 5,
            scrollDirection: Axis.horizontal,),
        ),
      ],
    );
  }
}
