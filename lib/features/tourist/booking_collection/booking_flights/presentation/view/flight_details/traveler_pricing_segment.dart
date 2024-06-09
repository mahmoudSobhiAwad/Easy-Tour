
import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/available_rooms/services_facilites_in_hotel.dart';

class TravelerPricingSegmentItem extends StatelessWidget {
  const TravelerPricingSegmentItem({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(child: Text('Segment',style: CustomTextStyle.fontBold14,)),
        const Row(
          children: [
            Icon(Icons.leave_bags_at_home),
            Text('Included Checked Bags: 2')
          ],
        ),
        const Text('Cabin Type:  BUSINESS'),
        const Text('Amenities',style: CustomTextStyle.fontBold16,),
        SizedBox(
          height: height*0.15,
          child: GridView.builder(
              itemCount: 10,
              gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 4,crossAxisSpacing: width*0.2,mainAxisSpacing: height*0.015), itemBuilder: (context,index){
            return ServicesFacilitiesItem(facilityItem: 'Ticket is good',width: width,height: height,);
          }),
        ),
      ],
    );
  }
}