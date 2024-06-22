import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/data/flight_models/get_tickets_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/view/flight_result/all_custom_painter.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/view/flight_result/date_with_flight_route.dart';
class FlightTicketItem extends StatelessWidget {
  const FlightTicketItem({
    super.key,
    required this.width,
    required this.height,
    required this.model,
  });

  final double width;
  final double height;
  final GetTicketsModel model;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TicketClipper(),
      child: Container(
        width: width*0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          //boxShadow: [buildBoxShadow()],
          borderRadius: BorderRadius.circular(12),
          //border: Border.all(width: 2,color: thirdColor),
        ),
        padding:const EdgeInsets.all(10),
        child: Column(
          children: [
            DateWithFlightRoute(width: width, height: height,itineraries: model.goingItinerariesList,),
            SizedBox(height: height*0.03,),
            if(model.returnItinerariesList!=null)DateWithFlightRoute(width: width, height: height,itineraries: model.returnItinerariesList),
            SizedBox(height: height*0.04,),
            DashedLine(height: 2, color: Colors.black, dashWidth: 3, dashGap: 2, length: width),
            SizedBox(height: height*0.033,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Price',style: CustomTextStyle.fontBold16,),
                Text('${model.price} \$',style: CustomTextStyle.fontBold16,),
              ],
            )
          ],
        ),
      ),
    );
  }
}