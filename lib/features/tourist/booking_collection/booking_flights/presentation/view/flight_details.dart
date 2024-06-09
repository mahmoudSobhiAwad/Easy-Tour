import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/view/flight_result/flight_booking_ticket_item.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/view/flight_result/flight_result_app_bar.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/available_rooms/services_facilites_in_hotel.dart';

class FlightDetailsView extends StatelessWidget {
  const FlightDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final double width=BasicDimension.screenWidth(context);
    final double height=BasicDimension.screenHeight(context);
    return Scaffold(
      body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height:height*0.25,
                    child: ColoredBox(
                      color: ticketBasicColor,
                      child: CustomFlightTicketingAppBar(width: width,title: 'Flight Details',),),
              ),
                  const TicketInfo(),
                  TravelersPricing(width: width, height: height),
                  const Row(
                    children: [
                      Text('Check Required Data',style: CustomTextStyle.privateTourTitle,),
                      IconButton(onPressed: null, icon: Icon(Icons.library_books_rounded)),
                    ],
                  ),
                  CustomLoginButton(label: 'Continue',altWidth: width*0.5,color:ticketBasicColor ,),
                ],
              ),
              Positioned(
                  top: height*0.15,
                  child: FlightTicketItem(width: width, height: height)),
              
            ],
          )),
    );
  }
}
class TicketInfo extends StatelessWidget {
  const TicketInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Ticket Info',style: CustomTextStyle.privateTourTitle.copyWith(fontSize: 18)),
        const Row(
          children: [
            Text('Instant Ticket Required',style: CustomTextStyle.commonSignThinDark,),
            Icon(Icons.close,color: closeColor,),
            Spacer(),
            Text('Instant Ticket Required',style: CustomTextStyle.commonSignThinDark,),
            Icon(Icons.close,color: closeColor)
          ],
        ),
        const Text('Last Ticketing Day : 28 Jun 2024',style: CustomTextStyle.commonSignThinDark,)
      ],
    );
  }
}

class TravelersPricing extends StatelessWidget {
  const TravelersPricing({super.key,required this.width,required this.height});
final double height;
final double width;
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        const Text('Traveler Pricing'),
        ListView.separated(itemBuilder: (context,index){
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: thirdColor),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Passenger${index+1}',style: CustomTextStyle.commonSignThinDark,), 
                    ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: ColoredBox(color: thirdColor,child: Text('Adult',style: CustomTextStyle.commonFontThin.copyWith(color: basicColor),),))
                  ],
                ),
                const Text('Total Pricing:1200 \$'),
                const Row(
                  children: [
                    Icon(Icons.do_not_disturb_on_total_silence_rounded),
                    Text('Fare Details by segment',style: CustomTextStyle.commonSignDark,),
                  ],
                ),
                Column(
                  children: [
                    ...List.generate(2, (index) {
                      return Column(
                        children: [
                          Text('Segment ${index+1}'),
                          const Row(
                            children: [
                              Icon(Icons.leave_bags_at_home),
                              Text('Included Checked Bags: 2')
                            ],
                          ),
                          const Text('Cabin Type:  BUSINESS'),
                          const Text('Amenities',style: CustomTextStyle.commonSignDark,),
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
                    }),
                  ],
                ),
              ],
            ),
          );
        }, separatorBuilder: (context,index){
          return SizedBox(
            height:height*0.02,
          );
        }, itemCount: 3)
      ],
    );
  }
}


