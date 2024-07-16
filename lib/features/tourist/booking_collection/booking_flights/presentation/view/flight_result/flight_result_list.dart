import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/data/flight_models/get_tickets_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/view/flight_details/flight_details.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/view/flight_result/flight_booking_ticket_item.dart';
class FlightResultList extends StatelessWidget {
  const FlightResultList({
    super.key,
    required this.height,
    required this.width,
    required this.ticketsList,
    required this.travelerNum,
  });
  final double height;
  final double width;
  final List<GetTicketsModel>ticketsList;
  final int travelerNum;
  @override
  Widget build(BuildContext context) {
    return ticketsList.isNotEmpty?SizedBox(
      height: height*0.7,
      child: ListView.separated(
        itemCount: ticketsList.length,
        padding: const EdgeInsets.all(20),
        itemBuilder:(context,index)
        {
          return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return  FlightDetailsView(model: ticketsList[index],index: index,travelerNum:travelerNum ,);
                }));
              },
              child: FlightTicketItem(width: width, height: height,model: ticketsList[index],));
          },
        separatorBuilder: (context,index){
          return SizedBox(height: height*0.015,);
          },
      ),
    ):
    SizedBox(
        height: height*0.6,
        child: Center(child: Text('There is No Available Planes In this Date ',style: CustomTextStyle.fontBold21,maxLines: 3,textAlign: TextAlign.center,),));
  }
}

