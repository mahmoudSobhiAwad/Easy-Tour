import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/features/tourist/custom_trip/presentation/manager/custom_trip_cubit.dart';
import 'package:prepare_project/features/tourist/custom_trip/presentation/manager/custom_trip_states.dart';
import 'package:prepare_project/features/tourist/custom_trip/presentation/views/widgets/CreatedCustomTrips.dart';
import 'package:prepare_project/features/tourist/custom_trip/presentation/views/widgets/custom_trip_body.dart';
class CustomTripView extends StatelessWidget {
  const CustomTripView({super.key});

  @override
  Widget build(BuildContext context) {
    final double height=BasicDimension.screenHeight(context);
    final double width=BasicDimension.screenWidth(context);
    return  BlocProvider(
      create: (context)=>CustomTripCubit(),
      child: BlocConsumer<CustomTripCubit,CustomTripState>(
          builder: (context,state) {
            var cubit=BlocProvider.of<CustomTripCubit>(context);
            return [
              MadeCustomTripsBody(width: width, height: height,cubit: cubit,),
              WillPopScope(
                  onWillPop: ()async{
                    if(cubit.toggleIndex==1){
                      cubit.moveToNextPage(0);
                      return false;
                    }
                    return false;
                  },
                  child: Scaffold(body: CustomTripBody(height: height, width: width,cubit: cubit,),)),
            ][cubit.toggleIndex];
            },
          listener: (context,state){}),);
  }
}







