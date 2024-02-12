import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/manager/generate_trip_cubit.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/manager/generate_trip_state.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/views/widgets/generate_trip_body.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/views/widgets/intro_generate_trip.dart';

class GenerateAiTrip extends StatelessWidget {
  const GenerateAiTrip({super.key});

  @override
  Widget build(BuildContext context) {
    final double height=BasicDimension.screenHeight(context);
    final double width=BasicDimension.screenWidth(context);
    return BlocProvider(
      create: (context)=>GenerateAiTripCubit(),
      child:BlocConsumer<GenerateAiTripCubit,GenerateAiTripState>(
          builder: (context,state){
            var cubit=BlocProvider.of<GenerateAiTripCubit>(context);
            return Scaffold(
                body:
                [
                  GenerateAiTripIntro(onTap: (){
                  cubit.navToGenerateTripScreen();
                },height: height, width: width),
                  GenerateTripBody(cubit: cubit,height: height,width: width,)
                ][cubit.pageCurrIndex]
        );
      }, listener:(context,state){} ) ,
    );
  }
}


