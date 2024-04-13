import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_app_bar_trip_generated.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/manager/view_trip_details_cubit/view_trip_details_cubit.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/manager/view_trip_details_cubit/view_trip_details_state.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/views/widgets/list_of_days_of_trip.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/views/widgets/trip_details_widgets/activity_list.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/views/widgets/trip_details_widgets/hote_list.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/views/widgets/trip_details_widgets/restaurants_list.dart';

class GeneratedTripDetailsWithAiView extends StatelessWidget {
  const GeneratedTripDetailsWithAiView({super.key,required this.startDate});
  final String?startDate;
  @override
  Widget build(BuildContext context) {
    final double height=BasicDimension.screenHeight(context);
    final double width=BasicDimension.screenWidth(context);
    return BlocProvider(create: (context)=>ViewTripDetailsCubit(startDate: startDate)..addDaysDates(),
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
                      itemCount: 4,
                      itemBuilder: (context,pageIndex){
                        return ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            ListOfDaysOfTrip(onTap: (index) {
                              cubit.moveToSpecificDay(index);
                            },height: height, currentDay: pageIndex,controller: cubit.controller, width: width,listOfDaysLength:4),
                            Text(cubit.daysDatesName[pageIndex],style: CustomTextStyle.placesTitle,),
                            const SizedBox(height: 15,),
                            ActivityListWithBar(height: height, width: width, cubit:cubit),
                            const SizedBox(height: 15,),
                            RestaurantsListWithBar(height: height, width: width, cubit:cubit),
                            const SizedBox(height: 15,),
                            HotelsListWithBar(height: height, width: width, cubit: cubit),
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







