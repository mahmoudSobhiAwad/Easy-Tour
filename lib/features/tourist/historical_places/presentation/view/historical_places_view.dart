import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/features/tourist/historical_places/presentation/manager/historical_places_bloc.dart';
import 'package:prepare_project/features/tourist/historical_places/presentation/manager/historical_places_states.dart';
import 'package:prepare_project/features/tourist/historical_places/presentation/view/widgets/historical_places_body.dart';

class HistoricalPLacesView extends StatelessWidget {
  const HistoricalPLacesView({super.key});

  @override
  Widget build(BuildContext context) {
    double width=BasicDimension.screenWidth(context);
    double height=BasicDimension.screenHeight(context);
    return  BlocProvider(
      create: (context){
        return HistoricalPlacesCubit();
        },
      child: BlocConsumer<HistoricalPlacesCubit,HistoricalPlacesState>(
        builder: (context,state){
         var cubit=BlocProvider.of<HistoricalPlacesCubit>(context);
          return HistoricalPlacesBody(height: height, width: width,cubit: cubit,);
        },
        listener: (context,state){},
      ),
    );
  }
}














