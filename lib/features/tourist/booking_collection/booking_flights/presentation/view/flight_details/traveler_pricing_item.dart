import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/view/flight_details/traveler_pricing_segment.dart';

class TravelersPricingItem extends StatelessWidget {
  const TravelersPricingItem({super.key,required this.width,required this.height});
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Container(
        width: width,
        padding:const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: thirdColor,width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Passenger',style: CustomTextStyle.fontBold16,),
                ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: ColoredBox(color: thirdColor,child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text('Adult',style: CustomTextStyle.fontNormal14WithEllipsis.copyWith(color: basicColor),),
                    ),)),
              ],
            ),
            const SizedBox(height: 7,),
            const Text('Total Pricing:1200 \$'),
            const SizedBox(height: 7,),
            const Row(
              children: [
                Icon(Icons.do_not_disturb_on_total_silence_rounded),
                Text('Fare Details by segment',style: CustomTextStyle.fontBold16,),
              ],
            ),
            Column(
              children: [
                ...List.generate(2, (index) {
                  return TravelerPricingSegmentItem(height: height, width: width);
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}