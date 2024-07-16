import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/function/service_locator.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/manager/rest_hotel_cubit/rest_hotel_cubit.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/manager/rest_hotel_cubit/rest_hotel_state.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/views/widgets/resturants_hotels_details_view/rest_or_hotel_details_body.dart';
import 'package:prepare_project/features/tourist/nearby_places/data/models/nearby_places_model.dart';
import 'package:prepare_project/features/tourist/nearby_places/data/repos/photo_repo/get_photo_repo_imp.dart';
class RestaurantOrHotelDetailsView extends StatelessWidget {
  const RestaurantOrHotelDetailsView({super.key,required this.model});
  final NearbyPlacesModel model;

  @override
  Widget build(BuildContext context) {
    double width=BasicDimension.screenWidth(context);
    double height=BasicDimension.screenHeight(context);
    return  BlocProvider(
      create: (context)=>RestHotelDetailsCubit(model: model,photoOfPlaceRepoImp:getIt.get<PhotoOfPlaceRepoImp>())..getPhotoPlaceList(),
      child: Scaffold(
        body: BlocConsumer<RestHotelDetailsCubit,RestHotelDetailsState>(
          builder:(context,state){
            var cubit=BlocProvider.of<RestHotelDetailsCubit>(context);
            return RestaurantOrHotelDetailsBody(width: width, height: height,model: model, cubit: cubit,);
          },
          listener: (context,state){},
      ),
    ));
  }
}








