import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_app_bar_trip_generated.dart';
import 'package:prepare_project/features/tourist/custom_trip/presentation/manager/custom_trip_cubit.dart';
import 'package:prepare_project/features/tourist/custom_trip/presentation/views/widgets/created_custom_trip_item.dart';
class MadeCustomTripsBody extends StatelessWidget {
  const MadeCustomTripsBody({super.key,required this.width,required this.height,required this.cubit});
  final double width;
  final double height;
  final CustomTripCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CircleAvatar(
        backgroundColor: entertainmentColor,
        radius: width*0.075,
        child: IconButton(
            iconSize: 40,
            onPressed:(){
              cubit.moveToNextPage(1);
            },
            icon: const Icon(Icons.create_rounded,color: Colors.white,)),),
      body: SafeArea(
          child:Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: CustomGeneratedAiTripAppBar(height: height, width: width,appBarTitle: 'Custom Trips',),
              ),
              Expanded(
                  child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: width*0.033,vertical:height*0.025,),
                      itemBuilder: (context,index) {
                        return CreatedCustomTripItem(width: width,height: height,);
                      }, separatorBuilder: (context,index){
                    return SizedBox(height: height*0.025,);
                  }, itemCount: 4)),
            ],
          )),
    );
  }
}