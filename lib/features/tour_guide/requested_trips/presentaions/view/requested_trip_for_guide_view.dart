import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/function/service_locator.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_container.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_types.dart';
import 'package:prepare_project/features/tour_guide/requested_trips/data/repos/get_all_request_repo/get_all_request_with_feedback_repo_imp.dart';
import 'package:prepare_project/features/tour_guide/requested_trips/presentaions/manager/requested_trip_for_guide/requested_trip_for_guide_cubit.dart';
import 'package:prepare_project/features/tour_guide/requested_trips/presentaions/manager/requested_trip_for_guide/requested_trip_for_guide_states.dart';
import 'package:prepare_project/features/tour_guide/requested_trips/presentaions/view/widgets/requested_trip_for_guide_body.dart';
class RequestedTripsTourGuideView extends StatelessWidget {
  const RequestedTripsTourGuideView({super.key});

  @override
  Widget build(BuildContext context) {
    final double height=BasicDimension.screenHeight(context);
    final double width=BasicDimension.screenWidth(context);
    return BlocProvider(
      create: (context){return RequestedTripForGuideCubit(
          getAllRequestedTripRepoImpl: getIt.get<GetAllRequestedTripRepoImpl>(),)..getAllRequested();},
      child: BlocConsumer<RequestedTripForGuideCubit,RequestedTripForGuideStates>(
          builder: (context,state){
            var cubit=BlocProvider.of<RequestedTripForGuideCubit>(context);
            return Scaffold(
              body: RequestedTripsTourGuideBody(width: width, height: height,cubit: cubit,),
            );
      }, listener: (context,state){
        if(state is FailureGetRequestedTripForGuideStates){
          showDialog(context: context, builder: (context)=> ContainerAlertWidget(
            types: AlertTypes.failed,
            onTap: (){
              Navigator.pop(context);
            },
            content: '${state.errMessage}',));
        }
    }),);
  }
}





