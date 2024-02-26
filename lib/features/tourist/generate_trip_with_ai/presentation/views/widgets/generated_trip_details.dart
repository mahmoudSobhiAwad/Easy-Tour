import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/function/service_locator.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_container.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_types.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_app_bar_trip_generated.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/model/generated_trip_model.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/repos/generate_trip_repo_imp.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/manager/view_trip_details_cubit/view_trip_details_cubit.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/manager/view_trip_details_cubit/view_trip_details_state.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/views/widgets/list_of_days_of_trip.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/views/widgets/next_prev_bubbles.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/views/widgets/trip_details_in_one_day.dart';

import '../../../../../tour_guide/private_tour/presentation/view/widgets/edit_delete_trip_menu_options.dart';

class GeneratedTripDetailsView extends StatelessWidget {
  const GeneratedTripDetailsView({super.key,required this.model});
final GeneratedTripModel model;
  @override
  Widget build(BuildContext context) {

    final double height=BasicDimension.screenHeight(context);
    final double width=BasicDimension.screenWidth(context);
    return BlocProvider(create: (context)=>ViewTripDetailsCubit(generatedTripModel: model,generateTripRepoImp:getIt.get<GenerateTripRepoImp>()),
      child: BlocConsumer<ViewTripDetailsCubit,ViewTripDetailsState>(builder: (context,state){
        var cubit=BlocProvider.of<ViewTripDetailsCubit>(context);
        return Scaffold(
          backgroundColor:const Color(0xffF7F7F9),
          body: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 20,left: 20,top: height*0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomGeneratedAiTripAppBar(height: height, width: width,appBarTitle: 'Trip Details',menuToSaveTrip: EditOrAddTripOptionMenu(saveTrip: (){
                      cubit.uploadTrip();
                    },),),
                    ListOfDaysOfTrip(height: height, currentDay: cubit.currentDay,controller: cubit.controller, width: width,tripDaysName: model.days,),
                    Expanded(
                      child: SizedBox(
                          height: height*0.6,
                          child: ListView.builder(
                            itemCount: model.days[cubit.currentDay].places.length,
                            padding: EdgeInsets.zero,
                            physics:const BouncingScrollPhysics(),
                            itemBuilder: (context,index){
                              return OneTripPerDayItem(height: height, width: width,placeItem: model.days[cubit.currentDay].places[index],);
                              },
                          )
                      ),
                    ),
                  ],
                ),
              ),
              NextPrevDay(cubit: cubit, width: width, height: height),
            ],
          ),
        );
      },
        listener:(context,state){
        if(state is FailedToUploadTripState){
          showDialog(context: context, builder: (context)=> ContainerAlertWidget(
            types: AlertTypes.failed,
            onTap: (){
              Navigator.pop(context);
            },
            content: '${state.errMessage}',));
        }
        else if(state is SuccessToUploadTripState){
          showDialog(context: context, builder: (context)=> ContainerAlertWidget(
            types: AlertTypes.success,
            onTap: (){
              Navigator.pop(context);
            },
            content: 'Saved Successfully',));
        }

        }
      ),
    );
  }
}





