import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/view/flight_result/all_custom_painter.dart';

class FlightResultAppBar extends StatelessWidget {
  const FlightResultAppBar({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height*0.25,
      decoration: const BoxDecoration(
          color: ticketBasicColor,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),bottomRight: Radius.circular(12))
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          CustomFlightTicketingAppBar(width: width),
          SizedBox(height: height*0.05,),
          Stack(
            alignment: Alignment.topCenter,
            children: [
              CustomPaint(
                painter: ArcPainter(width: width,height: height),
                size: Size(width*0.7,height*0.05),
              ),
              Column(
                children: [
                  const RotatedBox(
                      quarterTurns: 1,
                      child: Icon(Icons.airplanemode_on,color: Colors.white,)),
                  Text('1 hr 40 M',style: CustomTextStyle.fontBold16.copyWith(color: Colors.white),),
                ],
              )
            ],
          ),
          SizedBox(
            width: width*0.85,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('NYC\nNew York City',style: CustomTextStyle.fontBold16.copyWith(color: Colors.white),textAlign: TextAlign.center,),
                Text('CAI\nCairo',style: CustomTextStyle.fontBold16.copyWith(color: Colors.white,),textAlign: TextAlign.center,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomFlightTicketingAppBar extends StatelessWidget {
  const CustomFlightTicketingAppBar({
    super.key,
    required this.width,
    this.title,
  });

  final double width;
  final String?title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          backgroundColor: basicColor.withOpacity(0.2),
          child: Center(
            child: IconButton(onPressed: (){
              Navigator.pop(context);},
              icon: const Icon(Icons.arrow_back,color: Colors.white,),
            ),
          ),
        ),
        Text(title??'Flight Result',style: CustomTextStyle.fontBold16.copyWith(color: Colors.white),)
        ,SizedBox(width:width*0.1 ,),
      ],
    );
  }
}