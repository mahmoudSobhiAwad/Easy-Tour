import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/trip_history/presentation/view/widgets/trip_history_item.dart';
class TripHistoryBody extends StatelessWidget {
  const TripHistoryBody({super.key,required this.height,required this.width});
  final double width ;
  final double height ;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding:const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Current Trip',style: CustomTextStyle.fontBold16,),
              const SizedBox(height: 10,),
              SizedBox(
                height: height*0.25,
                child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: 3,
                    itemBuilder: (context,index){
                      return TripHistoryItem(height: height, width: width, tripType: 'Custom Trip', tripTitle: 'Trip To Egypt in 10 Day', leftIcon: const Icon(Icons.circle,color: whatsAppColor,size: 15,));
                    }),
              )
            ],
          ),
          SizedBox(height: height*0.02,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('UpComing Trips',style: CustomTextStyle.fontBold16,),
              const SizedBox(height: 10,),
              SizedBox(
                height: height*0.25,
                child: ListView.builder(

                    padding: const EdgeInsets.all(10),
                    itemCount: 3,
                    itemBuilder: (context,index){
                      return TripHistoryItem(behindTitle: const IconButton(onPressed: null, icon: Icon(Icons.delete,color: closeColor,)),height: height, width: width, tripType: 'Tour Guide Trip', tripTitle: 'Trip To Egypt in 10 Day', leftIcon: const Icon(Icons.access_time_rounded,color: entertainmentColor,));
                    }),
              )
            ],
          ),
          SizedBox(height: height*0.02,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Completed Trips',style: CustomTextStyle.fontBold16,),
              const SizedBox(height: 10,),
              SizedBox(
                height: height*0.25,
                child: ListView.builder(
                    itemCount: 3,
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context,index){
                      return TripHistoryItem(behindTitle: const IconButton(onPressed: null, icon: Icon(Icons.repeat,color: basicColor,)),height: height, width: width, tripType: 'Tour Guide Trip', tripTitle: 'Trip To Egypt in 10 Day', leftIcon: const Icon(Icons.check,color: whatsAppColor,));
                    }),
              )
            ],
          ),
        ],
      ),
    );
  }
}