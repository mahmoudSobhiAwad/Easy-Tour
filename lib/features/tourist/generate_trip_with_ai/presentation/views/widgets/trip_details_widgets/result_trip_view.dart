import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_app_bar_trip_generated.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/model/generated_trip_model.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/manager/view_trip_details_cubit/view_trip_details_cubit.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/manager/view_trip_details_cubit/view_trip_details_state.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/views/widgets/list_of_days_of_trip.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/views/widgets/trip_details_widgets/activity_list.dart';
import 'package:prepare_project/features/tourist/google_map/presentaion/view/google_map_view.dart';


class GeneratedTripDetailsWithAiView extends StatelessWidget {
  const GeneratedTripDetailsWithAiView({super.key,required this.startDate,required this.model});
  final String?startDate;
  final GeneratedTripModel model;
  @override
  Widget build(BuildContext context) {
    final double height=BasicDimension.screenHeight(context);
    final double width=BasicDimension.screenWidth(context);
    return BlocProvider(create: (context)=>ViewTripDetailsCubit(startDate: startDate,generatedTripModel:model )..addDaysDates()..fillLatLangList(),
      child: BlocConsumer<ViewTripDetailsCubit,ViewTripDetailsState>(builder:(context,state)
      {
        var cubit=BlocProvider.of<ViewTripDetailsCubit>(context);
        return Scaffold(
          body:  Padding(
            padding: EdgeInsets.only(right: 10,left: 10,top: height*0.05,bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomGeneratedAiTripAppBar(height: height, width: width,appBarTitle: 'Trip Details',menuToSaveTrip: SaveGeneratedTripButton(height: height, width: width),),
                Expanded(
                  child: PageView.builder(
                      physics:const NeverScrollableScrollPhysics(),
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
                            Text('${cubit.daysDatesName[pageIndex]},${cubit.generatedTripModel?.placesNames[pageIndex]}',style: CustomTextStyle.fontGrover22,),
                            const SizedBox(height: 15,),
                            ActivityListWithBar(height: height, width: width, cubit:cubit,pageIndex:pageIndex),
                            const SizedBox(height: 15,),
                            const Text('Trip In Map',style:CustomTextStyle.fontGrover22,),
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


class SaveGeneratedTripButton extends StatelessWidget {
  const SaveGeneratedTripButton({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        showModalBottomSheet(context: context,
            isScrollControlled: true,
            builder: (context){
              return SingleChildScrollView(
                padding:EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.bottom+5,),
                child: Container(
                  height: height*0.3,
                  padding: const EdgeInsets.all(7),
                  decoration:const BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft:Radius.circular(15) ,topRight:Radius.circular(15)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: (){
                        Navigator.pop(context);
                      }, icon: const Icon(Icons.close)),
                      const CustomTextFormField(enable: true,borderColor: secondaryColor,label: 'Trip Title',floatingLabelBehavior: FloatingLabelBehavior.never,),
                      Center(child: CustomLoginButton(label: 'Save',altWidth: width*0.4,)),
                    ],
                  ),
                ),
              );
        });
      },
        child: const Icon(Icons.bookmark_border,color: entertainmentColor,size: 30,));
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
          GoogleMap(
            markers: getMarkers(points),
            initialCameraPosition: CameraPosition(target: points[0],zoom: 10),polylines:  {
             Polyline(color: closeColor,polylineId:const PolylineId('generatedTripPolyLines'),points: points)
          },),
          points.isEmpty?const CircularProgressIndicator(color: basicColor,):const SizedBox(),
          Align(
            alignment: Alignment.topRight,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child:IconButton(onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: (context){
                  return GoogleMapView(markers: getMarkers(points),initialLatLng: points[0],polyLines:{
                  Polyline(color: closeColor,polylineId:const PolylineId('generatedTripPolyLines'),points: points)
                  },);
                }));
              }, icon: const Icon(Icons.close_fullscreen_rounded,color: basicColor)),
            ),
          )
        ],
      )

    );
  }
}

Set<Marker>getMarkers(List<LatLng>points){
  Set<Marker>markers={};
  for(int i=0;i<points.length;i++){
    markers.add(Marker(markerId: MarkerId('$i'),position:points[i]));
  }
  return markers;
}






