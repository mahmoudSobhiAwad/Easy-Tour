import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/two_beside_form.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/data/flight_models/get_tickets_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/view/flight_details/codes_with_duration.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/view/flight_result/all_custom_painter.dart';
class FlightTicketInDetailsView extends StatelessWidget {
  const FlightTicketInDetailsView({super.key,required this.width,required this.height,required this.model});
  final double width;
  final double height;
  final GetTicketsModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: whiteColor,
        border: Border.all(color: thirdColor,width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Text('Going Trip',style: CustomTextStyle.fontBold18,),
          SizedBox(
            height: height*0.12,
            child: ListView.separated(itemBuilder: (context,index){
              return CodesWithDividerAndDuration(width: width,segments: model.goingItinerariesList!.segments[index],duration: model.goingItinerariesList?.duration,);
            }, separatorBuilder: (context,index){
              return SizedBox(
                height: height*0.03,
                child: const VerticalDivider(
                  width: 2,
                  thickness: 1,
                  color: entertainmentColor,
                ),
              );
            }, itemCount: model.goingItinerariesList?.segments.length??0),
          ),
          SizedBox(height: height*0.04,),
          const Text('Return Trip',style: CustomTextStyle.fontBold18,),
          SizedBox(
            height: height*0.12,
            child: ListView.separated(itemBuilder: (context,index){
              return CodesWithDividerAndDuration(width: width, segments: model.returnItinerariesList!.segments[index],duration: model.returnItinerariesList?.duration,);
            }, separatorBuilder: (context,index){
              return SizedBox(
                height: height*0.03,
                child: const VerticalDivider(
                  width: 2,
                  thickness: 1,
                  color: entertainmentColor,
                ),
              );
            }, itemCount: model.goingItinerariesList?.segments.length??0),
          ),
          SizedBox(height: height*0.025,),
          DashedLine(height: 2, color: secondaryColor, dashWidth: 3, dashGap: 2, length: width),
          SizedBox(height: height*0.025,),
          CustomTwoFieldForm(
            firstText: 'Departure Date',
            firstCustomFormField: Container(
              width: width*0.4,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(color: secondaryColor,width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child:  Row(
                children: [
                  const Icon(Icons.date_range_rounded),
                  SizedBox(
                      width: width*0.3,
                      child: Text('${model.goingItinerariesList?.segments.first.departureSeg.timeToLeave}',maxLines: 2,textAlign: TextAlign.center,)),
                ],
              ),
            ),
            secondCustomFormField: Container(
              width: width*0.4,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(color: secondaryColor,width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child:  Row(
                children: [
                  const Icon(Icons.date_range_rounded),
                  SizedBox(
                      width: width*0.3,
                      child: Text('${model.returnItinerariesList?.segments.last.arrivalSeg.timeToLeave}',maxLines: 2,textAlign: TextAlign.center,)),
                ],
              ),
            ),
            secondText: 'Return Date',
          ),
          SizedBox(height: height*0.015,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Price',style: CustomTextStyle.fontBold30,),
              Text('${model.price} \$',style: CustomTextStyle.fontBold30,),
            ],
          )
        ],
      ),
    );
  }
}