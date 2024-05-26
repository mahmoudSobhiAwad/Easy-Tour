import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/models/destinations_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/place_destination.dart';

class TrendingDestinationInHotelBooking extends StatelessWidget {
  const TrendingDestinationInHotelBooking({super.key,required this.width,required this.height,required this.onTap});
  final double width;
  final double height;
  final void Function(DestinationModel val) onTap;
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
            ...List.generate(destList.sublist(0,3).length, (index){
              return GestureDetector(
                  onTap: (){
                    onTap(destList[index]);
                  },
                  child: PlaceDestinationInHotelBooking(height: height, width: width,lastWidth:index==2? width:null,destinationModel: destList[index],));
            }),
          ],
        ),
      ],
    );
  }
}