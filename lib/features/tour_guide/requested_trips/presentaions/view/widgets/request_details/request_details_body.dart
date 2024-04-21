import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_app_bar_trip_generated.dart';
import 'package:prepare_project/features/tour_guide/requested_trips/data/models/handle_request_model.dart';
import 'package:prepare_project/features/tour_guide/requested_trips/presentaions/manager/handle_request_cubit/handle_request_cubit.dart';
import 'package:prepare_project/features/tour_guide/requested_trips/presentaions/view/widgets/request_details/additional_request_widget.dart';
import 'package:prepare_project/features/tour_guide/requested_trips/presentaions/view/widgets/request_details/personal_info_for_tourist_to_book.dart';
import 'package:prepare_project/features/tour_guide/requested_trips/presentaions/view/widgets/request_details/requested_details_for_guide.dart';
import 'package:prepare_project/features/tour_guide/requested_trips/presentaions/view/widgets/request_details/requested_trip_requires.dart';
import 'package:prepare_project/features/tour_guide/requested_trips/presentaions/view/widgets/request_details/tourist_contact_info_in_requested_trip.dart';
class RequestDetailsBody extends StatelessWidget {
  const RequestDetailsBody({
    super.key,
    required this.height,
    required this.width,
    required this.model,
    required this.cubit,
  });


  final double height;
  final double width;
  final RequestsTripForTGModel model;
  final HandleRequestCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding:const EdgeInsets.symmetric(horizontal: 15).copyWith(bottom: 10),
        children: [
          CustomGeneratedAiTripAppBar(height: height, width: width,appBarTitle: 'Request Details',),
          PersonalInfoForTourist(model: model.requestedBy!, height: height, width: width),
          RequestedTripInfo(height: height, model: model.requestedTripModel!, width: width),
          RequestedDetails(height: height, model: model.requestedTripDetailsModel!, width: width),
          TouristContactInfo(height: height, model: model.requestedBy!, width: width),
          AdditionalRequest(height: height, comment: model.comment),
          SizedBox(height: height*0.015,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomLoginButton(color: closeColor,altWidth: width*0.45,label: 'Reject',borderRadius: 12,onTap: (){
                cubit.sendHandleFeedBack(answer: 'no');
              },),
              CustomLoginButton(color: const Color(0xff2DA056),altWidth: width*0.45,label: 'Accept',borderRadius: 12,onTap: (){
                cubit.sendHandleFeedBack(answer: 'yes');
              },),
            ],
          )
        ],
      ),
    );
  }
}