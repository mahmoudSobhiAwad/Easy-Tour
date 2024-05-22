import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/date_range_pass_num_destination.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/explore_egypt_destination.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/hotel_result/hotel_result_view.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/trending_destination.dart';

class HotelBookingView extends StatelessWidget {
  const HotelBookingView({super.key});

  @override
  Widget build(BuildContext context) {
    final double width=BasicDimension.screenWidth(context);
    final double height=BasicDimension.screenHeight(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset('assets/hotel_booking/booking_background.png',width: width,height: height*0.3,fit: BoxFit.cover,),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: height*0.77,
                width: width,
                decoration:const BoxDecoration(
                    color: Colors.white,
                    borderRadius:  BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: height*0.18),
                  child: ListView(
                    padding: const EdgeInsets.all(14),
                    children: [
                      TrendingDestinationInHotelBooking(width: width, height: height),
                      SizedBox(height: height*0.025,),
                      ExploreEgyptDestination(height: height, width: width),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                top: height*0.16,
                left: width*0.025,
                child: DateWithPassengerNumbersWithPlace(height: height, width: width,onSearch: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return const HotelResultView();
                  }));
                },))
          ],
        ),
      ),
    );
  }
}


