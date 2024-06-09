import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_app_bar_trip_generated.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/view/create_order/traveler_requirement_for_flight_booking_item.dart';
class CreateFlightOrderView extends StatelessWidget {
  const CreateFlightOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    final double width=BasicDimension.screenWidth(context);
    final double height=BasicDimension.screenHeight(context);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 12).copyWith(bottom: 12),
          children: [
            CustomGeneratedAiTripAppBar(height: height, width: width,appBarTitle: 'Flight Booking',),
            SizedBox(height: height*0.015,),
            const Text('Fill All The Requirements For Travelers',style: CustomTextStyle.fontBold18,),
            SizedBox(height: height*0.01,),
            SizedBox(
              height: height*0.8,
              child: ListView.builder(
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: TravelerRequirementsForFlightBookingItem(width: width, height: height),
                    );
              }),
            ),
            SizedBox(height: height*0.015,),
            const CustomTextFormField(
              maxLines: 3,
              label: 'Remark....',
            ),
            SizedBox(height: height*0.015,),
            CustomLoginButton(
              color: ticketBasicColor,
              label: 'Create Order',
              altWidth: width*0.6,
              borderRadius: 10,
            ),
          ],
        ),
      ),
    );
  }
}







