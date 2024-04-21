import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/function/service_locator.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_container.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_types.dart';
import 'package:prepare_project/features/tour_guide/requested_trips/data/models/handle_request_model.dart';
import 'package:prepare_project/features/tour_guide/requested_trips/data/repos/get_all_request_repo/get_all_request_with_feedback_repo_imp.dart';
import 'package:prepare_project/features/tour_guide/requested_trips/presentaions/manager/handle_request_cubit/handle_request_cubit.dart';
import 'package:prepare_project/features/tour_guide/requested_trips/presentaions/manager/handle_request_cubit/handle_request_states.dart';
import 'package:prepare_project/features/tour_guide/requested_trips/presentaions/view/widgets/request_details/request_details_body.dart';
class RequestDetailsView extends StatelessWidget {
  const RequestDetailsView({super.key,required this.model,});
  final RequestsTripForTGModel model;
  @override
  Widget build(BuildContext context) {
    final double width=BasicDimension.screenWidth(context);
    final double height=BasicDimension.screenHeight(context);
    return BlocProvider(
      create:(context)=>HandleRequestCubit(requestID: model.tripID!, tripID: model.requestedTripModel!.id!, handleRequestRepImp: getIt.get<GetAllRequestedTripRepoImpl>()),
      child:BlocConsumer<HandleRequestCubit,HandleRequestStates>(
          builder: (context,state){
            var cubit=BlocProvider.of<HandleRequestCubit>(context);
            return Scaffold(
              body: RequestDetailsBody(height: height, width: width, model: model,cubit: cubit,),
            );
          },
          listener: (context,state){
            if(state is FailureSendHandleRequestState){
              showDialog(context: context, builder: (context)=> ContainerAlertWidget(
                types: AlertTypes.failed,
                onTap: (){
                  Navigator.pop(context);
                },
                content: '${state.errMessage}',));
            }
            else if(state is SuccessSendHandleRequestState){
              showDialog(context: context, builder: (context)=> ContainerAlertWidget(
                types: AlertTypes.success,
                onTap: (){
                   context.pop();
                   context.pop();
                },
                content: '${state.message}',));
            }
          }) ,);
  }
}















