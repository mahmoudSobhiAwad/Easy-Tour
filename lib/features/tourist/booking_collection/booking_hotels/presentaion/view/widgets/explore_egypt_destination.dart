import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/models/destinations_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/place_destination.dart';
class ExploreEgyptDestination extends StatelessWidget {
  const ExploreEgyptDestination({super.key,required this.height,required this.width,required this.onTap});
  final double width;
  final double height;
  final void Function(DestinationModel val) onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Explore Egypt',style: CustomTextStyle.fontBold21,),
        SizedBox(height: height*0.01,),
        SizedBox(
          height: height*0.15,
          child: ListView.separated(
            itemBuilder: (context,index){
              return GestureDetector(
                  onTap: (){
                    onTap(destList.reversed.elementAt(index));
                  },
                  child: PlaceDestinationInHotelBooking(height: height, width: width,destinationModel: destList.reversed.elementAt(index)));
            },
            separatorBuilder: (context,index){
              return SizedBox(width: width*0.025,);
            }, itemCount: destList.length,
            scrollDirection: Axis.horizontal,),
        ),
      ],
    );
  }
}
