import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/view/flight_result/all_custom_painter.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/view/flight_result/date_with_flight_route.dart';
class FlightTicketItem extends StatelessWidget {
  const FlightTicketItem({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TicketClipper(),
      child: Container(
        width: width*0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 2,color: basicColor),
        ),
        padding:const EdgeInsets.all(10),
        child: Column(
          children: [
            DateWithFlightRoute(width: width, height: height),
            SizedBox(height: height*0.03,),
            DateWithFlightRoute(width: width, height: height),
            SizedBox(height: height*0.04,),
            DashedLine(height: 2, color: Colors.black, dashWidth: 3, dashGap: 2, length: width),
            SizedBox(height: height*0.033,),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Price',style: CustomTextStyle.commonSignDark,),
                Text('1100.32 \$',style: CustomTextStyle.commonSignDark,),
              ],
            )
          ],
        ),
      ),
    );
  }
}