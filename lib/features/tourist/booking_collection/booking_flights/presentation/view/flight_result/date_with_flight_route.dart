import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/data/flight_models/get_tickets_model.dart';
class DateWithFlightRoute extends StatelessWidget {
  const DateWithFlightRoute({
    super.key,
    required this.width,
    required this.height,
    required this.itineraries,
  });

  final double width;
  final double height;
  final Itineraries? itineraries;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(itineraries?.segments.first.departureSeg.timeToLeave??"",style: CustomTextStyle.fontBold16,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(itineraries?.segments.first.departureSeg.iatCode??"",style: CustomTextStyle.fontBold16,),
            SizedBox(
              width: width*0.15,
              child: Divider(
                thickness: 3,
                height: height*0.01,
                color: entertainmentColor,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child:ColoredBox(color: ticketBasicColor,child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: itineraries!.segments.isNotEmpty? Text('${itineraries?.segments.length}- Stops',style: CustomTextStyle.fontNormal14WithEllipsis.copyWith(color: Colors.white)):Text('Direct',style: CustomTextStyle.fontNormal14WithEllipsis.copyWith(color: Colors.white)),),
              ),),
            SizedBox(
              width: width*0.15,
              child: Divider(
                thickness: 3,
                height: height*0.01,
                color: entertainmentColor,
              ),
            ),
            Text(itineraries?.segments.last.arrivalSeg.iatCode??"",style: CustomTextStyle.fontBold16,),
          ],
        )
      ],
    );
  }
}