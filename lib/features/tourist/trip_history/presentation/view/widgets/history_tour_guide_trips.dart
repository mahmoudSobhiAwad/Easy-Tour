import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tour_guide/private_tour/data/model/private_tour_model.dart';
import 'package:prepare_project/features/tourist/trip_history/presentation/view/widgets/trip_history_item.dart';
class TripHistoryOfTripsWithTourGuide extends StatelessWidget {
  const TripHistoryOfTripsWithTourGuide({super.key,required this.height,required this.width,required this.currentTrip,required this.finished,required this.upComing});
  final double width;
  final double height;
  final List<Trip>upComing;
  final List<Trip>finished;
  final List<Trip>currentTrip;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding:const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Current Trip',style: CustomTextStyle.fontBold21,),
              const SizedBox(height: 10,),
              currentTrip.isEmpty?
              const Center(child: Text('No Current Trips Try Make One',style: CustomTextStyle.fontBold18,)) :
              SizedBox(
                height:currentTrip.length>3?height*.4:height*0.25,
                child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: currentTrip.length,
                    itemBuilder: (context,index){
                      return TripHistoryItem(height: height, width: width, tripType: 'Trips With Tour Guides', tripTitle: '${currentTrip[index].title}', leftIcon: const Icon(Icons.circle,color: whatsAppColor,size: 15,),tripDuration:currentTrip[index].tripDetails?.length,);
                    }),
              )
            ],
          ),
          SizedBox(height: height*0.02,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('UpComing Trips',style: CustomTextStyle.fontBold21,),
              const SizedBox(height: 10,),
              upComing.isEmpty?const Center(child: Text('No UpComing Trips Try Make One',style: CustomTextStyle.fontBold18,)):SizedBox(
                height: upComing.length>3?height*.4:height*0.25,
                child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: upComing.length,
                    itemBuilder: (context,index){
                      return TripHistoryItem(besideTitle: const IconButton(onPressed: null, icon: Icon(Icons.delete,color: closeColor,)),height: height, width: width, tripType: 'Trips With Tour Guides', tripTitle: '${upComing[index].title}', leftIcon: const Icon(Icons.access_time_rounded,color: entertainmentColor,),tripDuration: upComing[index].tripDetails?.length,);
                    }),
              )
            ],
          ),
          SizedBox(height: height*0.02,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Completed Trips',style: CustomTextStyle.fontBold21,),
              const SizedBox(height: 10,),
              finished.isEmpty?const Center(child: Text('No Completed Trips Try Make One',style: CustomTextStyle.fontBold18,)):SizedBox(
                height:finished.length>3?height*.4:height*0.25,
                child: ListView.builder(
                    itemCount: finished.length,
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context,index){
                      return TripHistoryItem(besideTitle: const IconButton(onPressed: null, icon: Icon(Icons.repeat,color: basicColor,)),height: height, width: width, tripType: 'Trips With Tour Guides', tripTitle: '${finished[index].title}', leftIcon: const Icon(Icons.check,color: whatsAppColor,),tripDuration: finished[index].tripDetails?.length,);
                    }),
              )
            ],
          ),
        ],
      ),
    );
  }
}