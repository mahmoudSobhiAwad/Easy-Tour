import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/custom_trip/data/model/custom_trip_model.dart';
import 'package:prepare_project/features/tourist/trip_history/presentation/view/widgets/trip_history_item.dart';
class TripHistoryOfCustomTrips extends StatelessWidget {
  const TripHistoryOfCustomTrips({super.key,required this.height,required this.repeatTrip,required this.deleteTrip,required this.width,required this.currentTrip,required this.finished,required this.upComing});
  final double width;
  final double height;
  final List<CustomTripModel>upComing;
  final List<CustomTripModel>finished;
  final List<CustomTripModel>currentTrip;
  final void Function ({required String id}) deleteTrip;
  final void Function({required String id,required int numOfDays}) repeatTrip;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding:const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text('Current Trip',style: CustomTextStyle.fontBold21,),
              const SizedBox(height: 10,),
              currentTrip.isEmpty?
               Center(child: Text('No Current Trips Try Make One',style: CustomTextStyle.fontBold18,)) :
              SizedBox(
                height:currentTrip.length>3?height*.4:height*0.25,
                child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: currentTrip.length,
                    itemBuilder: (context,index){
                      return TripHistoryItem(height: height, width: width, tripType: 'Custom Trip', tripTitle: '${currentTrip[index].title}', leftIcon: const Icon(Icons.circle,color: whatsAppColor,size: 15,),tripDate:currentTrip[index].startDate ,tripDuration:currentTrip[index].durationNum,);
                    }),
              )
            ],
          ),
          SizedBox(height: height*0.02,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text('UpComing Trips',style: CustomTextStyle.fontBold21,),
              const SizedBox(height: 10,),
              upComing.isEmpty? Center(child: Text('No UpComing Trips Try Make One',style: CustomTextStyle.fontBold18,)):SizedBox(
                height: upComing.length>3?height*.4:height*0.25,
                child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: upComing.length,
                    itemBuilder: (context,index){
                      return TripHistoryItem(besideTitle: IconButton(onPressed: (){
                        deleteTrip(id:currentTrip[index].tripId!);
                      }, icon: Icon(Icons.delete,color: closeColor,)),height: height, width: width, tripType: 'Custom Trips', tripTitle: '${upComing[index].title}', leftIcon: const Icon(Icons.access_time_rounded,color: entertainmentColor,),tripDuration: upComing[index].durationNum,tripDate: upComing[index].startDate,);
                    }),
              )
            ],
          ),
          SizedBox(height: height*0.02,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text('Completed Trips',style: CustomTextStyle.fontBold21,),
              const SizedBox(height: 10,),
              finished.isEmpty? Center(child: Text('No Completed Trips Try Make One',style: CustomTextStyle.fontBold18,)):SizedBox(
                height:finished.length>3?height*.4:height*0.25,
                child: ListView.builder(
                    itemCount: finished.length,
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context,index){
                      return TripHistoryItem(besideTitle: Row(
                        children: [
                          IconButton(onPressed: (){
                            deleteTrip(id:finished[index].tripId!);
                            },icon: Icon(Icons.delete,color: closeColor,),),
                          IconButton(onPressed: (){
                            repeatTrip(id:finished[index].tripId!,numOfDays: finished[index].durationNum!);
                          }, icon: Icon(Icons.repeat,color: basicColor,)),
                        ],
                      ),height: height, width: width, tripType: 'Custom Trips', tripTitle: '${finished[index].title}', leftIcon: const Icon(Icons.check,color: whatsAppColor,),tripDate: finished[index].startDate,tripDuration: finished[index].durationNum,);
                    }),
              )
            ],
          ),
        ],
      ),
    );
  }
}