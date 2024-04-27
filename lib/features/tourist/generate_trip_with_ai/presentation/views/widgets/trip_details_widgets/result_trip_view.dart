import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/function/service_locator.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_app_bar_trip_generated.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/model/generated_trip_model.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/manager/view_trip_details_cubit/view_trip_details_cubit.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/manager/view_trip_details_cubit/view_trip_details_state.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/views/widgets/list_of_days_of_trip.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/views/widgets/trip_details_widgets/activity_list.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/views/widgets/trip_details_widgets/hote_list.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/views/widgets/trip_details_widgets/restaurants_list.dart';
import 'package:prepare_project/features/tourist/nearby_places/data/repos/nearby_places_repo_imp.dart';

class GeneratedTripDetailsWithAiView extends StatelessWidget {
  const GeneratedTripDetailsWithAiView({super.key,required this.startDate,required this.model});
  final String?startDate;
  final GeneratedTripModel model;
  @override
  Widget build(BuildContext context) {
    final double height=BasicDimension.screenHeight(context);
    final double width=BasicDimension.screenWidth(context);
    return BlocProvider(create: (context)=>ViewTripDetailsCubit(startDate: startDate,nearbySearchRepoImp: getIt.get<NearbyPlacesRepoImpl>(),generatedTripModel:model )..addDaysDates()..fillLatLangList(),
      child: BlocConsumer<ViewTripDetailsCubit,ViewTripDetailsState>(builder:(context,state)
      {
        var cubit=BlocProvider.of<ViewTripDetailsCubit>(context);
        return Scaffold(
          body:  Padding(
            padding: EdgeInsets.only(right: 20,left: 20,top: height*0.05,bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomGeneratedAiTripAppBar(height: height, width: width,appBarTitle: 'Trip Details',menuToSaveTrip: const Icon(Icons.bookmark_border,color: entertainmentColor,size: 30,),),
                Expanded(
                  child: PageView.builder(
                      physics:const BouncingScrollPhysics(),
                      controller: cubit.pageController,
                      onPageChanged: (index){
                        cubit.pageChange(index);
                      },
                      itemCount: cubit.generatedTripModel?.days.length??0,
                      itemBuilder: (context,pageIndex){
                        return ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            ListOfDaysOfTrip(onTap: (index) {
                              cubit.moveToSpecificDay(index);
                            },height: height, currentDay: pageIndex,controller: cubit.controller, width: width,listOfDaysLength:cubit.generatedTripModel?.days.length??0,),
                            Text('${cubit.daysDatesName[pageIndex]},${cubit.generatedTripModel?.placesNames[pageIndex]}',style: CustomTextStyle.placesTitle,),
                            const SizedBox(height: 15,),
                            ActivityListWithBar(height: height, width: width, cubit:cubit,pageIndex:pageIndex),
                            const SizedBox(height: 15,),
                            RestaurantsListWithBar(height: height, width: width, cubit:cubit),
                            const SizedBox(height: 15,),
                            HotelsListWithBar(height: height, width: width, cubit: cubit),
                            const SizedBox(height: 15,),
                            const Text('Trip In Map',style:CustomTextStyle.placesTitle,),
                            const SizedBox(height: 15,),
                            TripInGoogleMapWithPolyLine(height: height,points: cubit.polyLinesList,),
                          ],
                        );
                      }),
                ),
              ],
            ),
          ),
        );
      },listener: (context,state){},
      ),
    );
  }
}
class TripInGoogleMapWithPolyLine extends StatelessWidget {
  const TripInGoogleMapWithPolyLine({super.key,required this.height,required this.points});
final double height;
final List<LatLng>points;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height*0.5,
      child:Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(initialCameraPosition: const CameraPosition(target: LatLng(30.586499288653258, 32.2710130807726),zoom: 12),polylines:  {
             Polyline(color: closeColor,polylineId:const PolylineId('generatedTripPolyLines'),points: points)
          },),
          points.isEmpty?const CircularProgressIndicator(color: basicColor,):const SizedBox(),
        ],
      )

    );
  }
}







