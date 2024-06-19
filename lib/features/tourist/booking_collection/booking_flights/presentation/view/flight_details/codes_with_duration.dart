import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/data/flight_models/get_tickets_model.dart';
class CodesWithDividerAndDuration extends StatelessWidget {
  const CodesWithDividerAndDuration({
    super.key,
    required this.width,
    required this.segments,
    this.duration,
  });

  final double width;
  final Segments segments;
  final String? duration;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(segments.departureSeg.iatCode,style: CustomTextStyle.fontBold14,),
        SizedBox(
          width: width*0.2,
          child: const Divider(
            thickness: 3,
            color: entertainmentColor,
            height: 2,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: ticketBasicColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(duration??"",style: CustomTextStyle.font16BoldWhite.copyWith(fontSize: 14),),
        ),
        SizedBox(
          width: width*0.2,
          child: const Divider(
            color: entertainmentColor,
            height: 2,
            thickness: 3,
          ),
        ),
        Text(segments.arrivalSeg.iatCode,style: CustomTextStyle.fontBold14,),
      ],
    );
  }
}