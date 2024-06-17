import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/function/service_locator.dart';
import 'package:prepare_project/features/tourist/trip_history/data/repos/trip_manager_repo_impl.dart';
import 'package:prepare_project/features/tourist/trip_history/presentation/manager/trip_history_cubit.dart';
import 'package:prepare_project/features/tourist/trip_history/presentation/manager/trip_history_states.dart';
import 'package:prepare_project/features/tourist/trip_history/presentation/view/widgets/trip_history_body.dart';
class TripHistoryView extends StatelessWidget {
  const TripHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = BasicDimension.screenWidth(context);
    final double height = BasicDimension.screenHeight(context);
    return BlocProvider(
      create: (context)=>TripManagerCubit(tripManagerRepoImpl: getIt.get<TripManagerRepoImpl>())..getTripHistoryList(),
      child:BlocConsumer<TripManagerCubit,TripManagerState>(builder:(context,state){
        var cubit=BlocProvider.of<TripManagerCubit>(context);
        return Scaffold(
          body: SafeArea(
            child:TripHistoryManagerBody(cubit: cubit, height: height, width: width,),
          ),
        );
      } ,listener:(context,state){} ,) ,
    );
  }
}







