import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';

import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
import 'package:prepare_project/features/tour_guide/private_tour/presentation/manager/edit_create_tour/edit_create_tour_cubit.dart';
import 'package:prepare_project/features/tour_guide/private_tour/presentation/view/widgets/bg_tour.dart';
import 'package:prepare_project/features/tour_guide/private_tour/presentation/view/widgets/include_exclude_widgets.dart';
import 'package:prepare_project/features/tour_guide/private_tour/presentation/view/widgets/min_person_tickets.dart';
import 'package:prepare_project/features/tour_guide/private_tour/presentation/view/widgets/model_bottom_create_edit.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/views/widgets/stepper_trip_days.dart';

class CreateOrEditPrivateTourBody extends StatelessWidget {
  const CreateOrEditPrivateTourBody({
    super.key,
    required this.cubit,
    required this.height,
    required this.width,
    this.editOrCreate=CreateOrEdit.edit,
    required this.index,
  });

  final CreateEditPrivateTourCubit cubit;
  final double height;
  final double width;
  final CreateOrEdit editOrCreate;
  final int? index;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ListView(
          padding: EdgeInsets.only(left: 20.0,right: 20,top: height*0.03,),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('title of the trip',style:CustomTextStyle.fontBold16,),
                const SizedBox(height: 5,),
                CustomTextFormField(
                  maxLines: 1,
                  controller: cubit.titleTextController,
                  label: 'add title for the trip.....',
                  border: 20,
                  fillColor: thirdColor,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  filled: true,
                  enableOutLine: false,),
              ],
            ),
            const SizedBox(height: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('brief of the trip',style:CustomTextStyle.fontBold16,),
                const SizedBox(height: 5,),
                CustomTextFormField(
                  controller: cubit.briefTextController,
                  label: 'add brief for your trip ....',
                  border: 20,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  maxLines: 2,
                  fillColor: thirdColor,
                  filled: true,
                  enableOutLine: false,
                ),
              ],
            ),
            const SizedBox(height: 20,),
            Column(
              children: [
                cubit.tripDay.isEmpty?
                const ClipRRect(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20),bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20)),
                  child: ColoredBox(
                    color: thirdColor,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Center(child: Text('Try To Add Days Of Trips In Egypt',style: CustomTextStyle.fontNormal16,)),
                    ),
                  ),
                ):
                StepperTripDay(cubit: cubit, height: height, width: width, tripDays: cubit.tripDay, currDay: cubit.currDay, goToSelectedDay: (int index){
                  cubit.goToSelectedDay(index);}),
                const SizedBox(height: 10,),
                Container(
                  width: width*0.4,
                  decoration: BoxDecoration(borderRadius:BorderRadius.circular(10),border: Border.all(color:secondaryColor),color: basicColor),
                  child:  TextButton(
                      onPressed:(){
                        cubit.changeShowAddDays();
                      },
                      child: Text("Add a Trip",
                        style: CustomTextStyle.fontBold14.copyWith(color: Colors.white))),
                ),
              ],
            ),
             // DetailsDayList(height: height, width: width,cubit: cubit,tripDays: cubit.tripDay,),
            const SizedBox(height: 20,),
            BGPrivateTourOption(height: height, cubit: cubit,width: width,),
            const SizedBox(height: 20,),
            MaxPersonPlanPrice(width: width,maxPerson: cubit.maxPersonTextController, cubit: cubit, height: height,),
            const SizedBox(height: 20,),
            IncludedOrExcludedFeatures(height: height, width: width, title: 'Included Feature in the trip', icon: Icons.check_circle, iconColor: whatsAppColor,
              incOrExc: cubit.included, addIncOrExc: () {
              cubit.addToIncludedList();
              }, removeIncOrExc: (int index) {
              cubit.removeFromIncludedList(index);
              }, controller: cubit.includedTextController,),
            const SizedBox(height: 20,),
            IncludedOrExcludedFeatures(height: height, width: width, title: 'Excluded Feature in the trip', icon: Icons.close, iconColor: closeColor,
              incOrExc: cubit.excluded, addIncOrExc: () {
              cubit.addToExcludedList();
              }, removeIncOrExc: (int index) {
              cubit.removeFromExcludedList(index);
              }, controller: cubit.excludedTextController,),
            const SizedBox(height: 20,),
            CustomLoginButton(
                isLoading: cubit.isLoading,
                label:switch(editOrCreate){
                  CreateOrEdit.create => 'Add',
                  CreateOrEdit.edit => 'Edit',
                },
                onTap:
                switch(editOrCreate){
                  CreateOrEdit.create => (){
                    cubit.createNewTrip();
                  },
                  CreateOrEdit.edit => (){
                    cubit.editCurrentTrip();
                  },
                }
            ),
            const SizedBox(height: 20,),
          ],
        ),
        cubit.showAddDay?
        AddOrEditTripModelBottom(
          changeType: (){
            cubit.changeTypeDay();
          },
          clearDay: (index){
            cubit.clearPlaceInOneDay(index);
          },
          onClose: (){
            cubit.changeShowAddDays();
          },
          height: height,
          dayNum: cubit.tripDay.length+1,
          width: width,
          placesOfDay:cubit.places,
          onTap: (){
            cubit.addTripDay(cubit.tripDay.length);
            cubit.changeShowAddDays();
          }, addAnotherPlaceInDay: () {
          cubit.addNewPlaceInNewDay();
        },
        ):
        const SizedBox()
      ],
    );
  }
}
enum CreateOrEdit{create,edit}
