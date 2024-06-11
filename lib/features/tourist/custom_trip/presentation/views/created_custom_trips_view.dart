import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/function/service_locator.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_container.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_types.dart';
import 'package:prepare_project/features/tourist/custom_trip/data/repos/custom_trip_repo_impl.dart';
import 'package:prepare_project/features/tourist/custom_trip/presentation/manager/get_custom_trip/get_custom_trips_cubit.dart';
import 'package:prepare_project/features/tourist/custom_trip/presentation/manager/get_custom_trip/get_custom_trips_states.dart';
import 'package:prepare_project/features/tourist/custom_trip/presentation/views/widgets/created_custom_trips.dart';

class CreatedCustomTripsView extends StatelessWidget {
  const CreatedCustomTripsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context)=>GetCustomTripCubit(customTripRepoImpl: getIt.get<CustomTripRepoImpl>())..getAllTrips(),
      child:BlocConsumer<GetCustomTripCubit,GetCustomTripsState>(
          builder: (context,state){
            var cubit=BlocProvider.of<GetCustomTripCubit>(context);
            return CreatedCustomTripsBody(cubit: cubit,);
      }, listener: (context,state){
            if(state is FailureGetCustomTripState){
              showDialog(context: context, builder: (context)=> ContainerAlertWidget(
                types: AlertTypes.failed,
                onTap: (){
                  Navigator.pop(context);
                },
                content: '${state.errMessage}',));
            }
      })
    );
  }
}
