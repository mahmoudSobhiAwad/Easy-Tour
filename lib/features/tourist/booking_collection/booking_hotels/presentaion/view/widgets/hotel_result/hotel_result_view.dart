import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_app_bar_trip_generated.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/date_range_pass_num_destination.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/hotel_result/one_hotel_item_in_result.dart';

class HotelResultView extends StatelessWidget {
  const HotelResultView({super.key});

  @override
  Widget build(BuildContext context) {
    final double width=BasicDimension.screenWidth(context);
    final double height=BasicDimension.screenHeight(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: CustomGeneratedAiTripAppBar(height: height, width: width,appBarTitle: 'Luxor:Hotels',appBarStyle: CustomTextStyle.privateTourTitle,),
            ),
            SizedBox(height: height*0.025,),
            DateWithPassengerNumbersWithPlace(height: height, width: width,onSearch: (){},),
            SizedBox(height: height*0.025,),
            Expanded(
              child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  itemBuilder: (context,index){
                return OneHotelItemInBooking(width: width, height: height);
              }, separatorBuilder: (context,index){
                    return SizedBox(height: height*0.025,);
              }, itemCount: 5),
            ),
          ],
        ),
      ),
    );
  }
}




