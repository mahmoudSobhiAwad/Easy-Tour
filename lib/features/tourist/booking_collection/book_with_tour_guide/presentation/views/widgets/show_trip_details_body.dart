import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_app_bar_trip_generated.dart';
import 'package:prepare_project/features/tour_guide/private_tour/data/model/private_tour_model.dart';
import 'package:prepare_project/features/tour_guide/private_tour/presentation/view/widgets/include_exclude_widgets.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/managers/tour_guide_trips_to_view_cubit.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/views/widgets/plan_to_stay.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/views/widgets/request_trip_widgets/request_trip_view.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/views/widgets/review_for_each_trip.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/views/widgets/stepper_trip_days.dart';
import 'package:prepare_project/features/tourist/profile/presentation/views/widgets/cover_profile_wiget.dart';
class ShowTourGuideTripsDetailsForTouristBody extends StatelessWidget {
  const ShowTourGuideTripsDetailsForTouristBody({
    super.key,
    required this.height,
    required this.width,
    required this.tripItem,
    required this.cubit,
  });

  final double height;
  final double width;
  final Trip tripItem;
  final TripsToViewCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding:const EdgeInsets.only(bottom: 20),
        children: [
          Stack(
            children: [
              CoverPictureWidget(widgetHeight: height*0.2,widgetWidth: width, coverUrl: tripItem.bgImagePath),
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
                Text(tripItem.title??"",style: CustomTextStyle.fontBold21,maxLines: 3,),
                Text(tripItem.brief??"",style: CustomTextStyle.font14Light,maxLines: 3,),
                const SizedBox(height: 10,),
                StepperTripDay(height: height, width: width, tripDays: tripItem.tripDetails,currDay:cubit.currDay, goToSelectedDay: (int index) {
                  cubit.goToSelectedDay(index);
                },),
                const SizedBox(height: 20,),
                IncludedOrExcludedFeatures(height: height, width: width, title: 'Included Feature', icon: Icons.check, iconColor: whatsAppColor, incOrExc:tripItem.included??[],showAddInc: false,),
                IncludedOrExcludedFeatures(height: height, width: width, title: 'Excluded Feature', icon: Icons.close, iconColor: closeColor, incOrExc:tripItem.excluded??[],showAddInc: false,),
                TypeOfStay(height: height, width: width,plan: tripItem.tripTicket,),
                ShowReviewInTourGuideTrip(height: height, width: width),
                const SizedBox(height: 20,),
                Center(child: CustomLoginButton(color: forthColor,label: 'Request',onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context){
                   return  RequestTripView(tripId: tripItem.tripId!,tripTicket: tripItem.tripTicket,tripDays: tripItem.tripDetails?.length.toString(),);
                 }));
                },))
              ],
            ),
          ),
        ],
      ),
    );
  }
}