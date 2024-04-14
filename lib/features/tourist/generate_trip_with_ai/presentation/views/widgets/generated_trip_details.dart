import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/function/service_locator.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_container.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_types.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_app_bar_trip_generated.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/model/generated_trip_model.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/repos/generate_trip_repo_imp.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/manager/view_trip_details_cubit/view_trip_details_cubit.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/manager/view_trip_details_cubit/view_trip_details_state.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/views/widgets/list_of_days_of_trip.dart';
import 'package:prepare_project/features/tourist/nearby_places/data/repos/nearby_places_repo_imp.dart';
import '../../../../../tour_guide/private_tour/presentation/view/widgets/edit_delete_trip_menu_options.dart';

class GeneratedTripDetailsView extends StatelessWidget {
  const GeneratedTripDetailsView({super.key,required this.model,required this.endDate,required this.startDate});
final GeneratedTripModel model;
final String?startDate;
final String?endDate;
  @override
  Widget build(BuildContext context) {

    final double height=BasicDimension.screenHeight(context);
    final double width=BasicDimension.screenWidth(context);
    return BlocProvider(create: (context)=>ViewTripDetailsCubit(startDate: startDate,endDate: endDate,generatedTripModel: model,generateTripRepoImp:getIt.get<GenerateTripRepoImp>(),nearbySearchRepoImp: getIt.get<NearbyPlacesRepoImpl>()),
      child: BlocConsumer<ViewTripDetailsCubit,ViewTripDetailsState>(builder: (context,state){
        var cubit=BlocProvider.of<ViewTripDetailsCubit>(context);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor:const Color(0xffF7F7F9),
          body: ListView(
            padding: EdgeInsets.only(right: 20,left: 20,top: height*0.05),
            children: [
              Padding(
                padding: EdgeInsets.only(right: 20,left: 20,top: height*0.05,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomGeneratedAiTripAppBar(height: height, width: width,appBarTitle: 'Trip Details',menuToSaveTrip: EditOrAddTripOptionMenu(
                      saveTrip: (){
                        showDialog(context: context, builder: (context){
                          return AlertDialog(
                            scrollable: true,
                            actionsAlignment: MainAxisAlignment.center,
                            actions: [
                              CustomLoginButton(
                                isLoading: cubit.isLoading,
                                altWidth: width*0.4,label: 'Save',onTap: (){
                                cubit.uploadTrip().then((value) {
                                  Navigator.pop(context);
                                });
                              },),
                            ],
                            title: const Text('Trip Title',style: CustomTextStyle.commonSignDark,),content: CustomTextFormField(
                            focusNode: cubit.focusNode,
                            controller: cubit.titleController,),);

                        });
                    },),),
                    Expanded(
                      child: PageView.builder(
                        physics:const BouncingScrollPhysics(),
                          controller: cubit.pageController,
                        onPageChanged: (index){
                          cubit.pageChange(index);
                        },
                          itemCount: cubit.generatedTripModel!.days.length,
                          itemBuilder: (context,pageIndex){
                        return Column(
                          children: [
                            ListOfDaysOfTrip(onTap: (index)
                            {
                              cubit.moveToSpecificDay(index);
                            },height: height, currentDay: pageIndex,controller: cubit.controller, width: width,listOfDaysLength: model.days.length,),
                            SizedBox(
                                height: height*0.75,
                                width: width,
                                child: ListView.builder(
                                  itemCount: model.days[pageIndex].places.length,
                                  physics:const BouncingScrollPhysics(),
                                  itemBuilder: (context,index){
                                    /// make new trip per day for generate trip
                                    return const SizedBox();
                                  },
                                )
                            ),
                          ],
                        );
                      }),
                    ),
                  ],
                ),
              ),
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





