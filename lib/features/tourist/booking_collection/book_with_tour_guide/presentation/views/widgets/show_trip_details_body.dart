import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_app_bar_trip_generated.dart';
import 'package:prepare_project/features/tour_guide/private_tour/presentation/view/widgets/include_exclude_widgets.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/views/widgets/plan_to_stay.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/views/widgets/request_trip_view.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/views/widgets/review_for_each_trip.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/views/widgets/stepper_trip_days.dart';
import 'package:prepare_project/features/tourist/profile/presentation/views/widgets/cover_profile_wiget.dart';
class ShowTourGuideTripsDetailsForTouristBody extends StatelessWidget {
  const ShowTourGuideTripsDetailsForTouristBody({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding:const EdgeInsets.only(bottom: 20),
        children: [
          Stack(
            children: [
              CoverPictureWidget(widgetHeight: height*0.2,widgetWidth: width, coverUrl: 'https://www.tripsavvy.com/thmb/-tzBp8Gy4A2v7-XK07TYecZXWfk=/2286x1311/filters:fill(auto,1)/GettyImages-200478089-001-06db86e7b540494a807a46af6c6c7f11.jpg'),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: CustomGeneratedAiTripAppBar(height: height, width: width),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width*0.025),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Discovering Spiritual Egypt in 11 days',style: CustomTextStyle.privateTourTitle,maxLines: 3,),
                const Text('Pyramids Meditation, Luxor Banks, 3-night Dahabiya Nile Cruise,Pyramids Meditation, Luxor Banks, 3-night Dahabiya Nile Cruise,Pyramids Meditation, Luxor Banks, 3-night Dahabiya Nile Cruise',style: CustomTextStyle.commonFontThinLight,maxLines: 3,),
                StepperTripDay(height: height, width: width),
                const SizedBox(height: 20,),
                IncludedOrExcludedFeatures(height: height, width: width, title: 'Included Feature', icon: Icons.check, iconColor: whatsAppColor, incOrExc:const[
                  'feature 1',
                  'feature 1',
                  'feature 1',
                  'feature 1',
                ],showAddInc: false,),
                IncludedOrExcludedFeatures(height: height, width: width, title: 'Excluded Feature', icon: Icons.close, iconColor: closeColor, incOrExc:const[
                  'feature 1',
                  'feature 1',
                  'feature 1',
                  'feature 1',
                ],showAddInc: false,),
                TypeOfStay(height: height, width: width),
                ShowReviewInTourGuideTrip(height: height, width: width),
                const SizedBox(height: 20,),
                Center(child: CustomLoginButton(color: forthColor,label: 'Request',onTap: (){
                  MaterialPageRoute(builder: (context){
                    return const RequestTripView();
                  });
                },))
              ],
            ),
          ),
        ],
      ),
    );
  }
}