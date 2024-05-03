import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/function/service_locator.dart';
import 'package:prepare_project/features/tourist/historical_places/presentation/manager/historical_places_bloc.dart';
import 'package:prepare_project/features/tourist/historical_places/presentation/manager/historical_places_states.dart';
import 'package:prepare_project/features/tourist/historical_places/presentation/view/widgets/historical_places_body.dart';
import 'package:prepare_project/features/tourist/tourist_home/data/repo/home_tourist_repo_impl.dart';

class DiscoverPLacesView extends StatelessWidget {
  const DiscoverPLacesView({super.key,});

  @override
  Widget build(BuildContext context) {
    double width=BasicDimension.screenWidth(context);
    double height=BasicDimension.screenHeight(context);
    return  BlocProvider(
      create: (context){
        return DiscoverPlacesCubit(homeTouristRepoImp: getIt.get<HomeTouristRepoImp>(),)..getPlaces();
        },
      child: BlocConsumer<DiscoverPlacesCubit,DiscoverPlacesStates>(
        builder: (context,state){
         var cubit=BlocProvider.of<DiscoverPlacesCubit>(context);
          return DiscoverPlacesBody(height: height, width: width,cubit: cubit,);
        },
        listener: (context,state){},
      ),
    );
  }
}














