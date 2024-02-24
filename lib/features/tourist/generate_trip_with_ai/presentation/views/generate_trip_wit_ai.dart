import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/function/service_locator.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/repos/generate_trip_repo_imp.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/manager/generate_trip_cubit.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/manager/generate_trip_state.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/views/widgets/generate_trip_body.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/views/widgets/generated_trip_details.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/views/widgets/intro_generate_trip.dart';

class GenerateAiTrip extends StatelessWidget {
  const GenerateAiTrip({super.key});

  @override
  Widget build(BuildContext context) {
    final double height=BasicDimension.screenHeight(context);
    final double width=BasicDimension.screenWidth(context);
    return BlocProvider(
      create: (context)=>GenerateAiTripCubit(generateTripRepoImp: getIt.get<GenerateTripRepoImp>())..requestAllowLocation(),
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
      }, listener:(context,state){
            if(state is SuccessSendRequestToGenerateTrip){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>GeneratedTripDetailsView(model:state.model)));
            }
      } ) ,
    );
  }
}


