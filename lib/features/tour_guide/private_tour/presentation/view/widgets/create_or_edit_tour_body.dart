import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
import 'package:prepare_project/features/tour_guide/private_tour/presentation/manager/edit_create_tour/edit_create_tour_cubit.dart';
import 'package:prepare_project/features/tour_guide/private_tour/presentation/view/widgets/bg_tour.dart';
import 'package:prepare_project/features/tour_guide/private_tour/presentation/view/widgets/details_day_list.dart';
import 'package:prepare_project/features/tour_guide/private_tour/presentation/view/widgets/min_person_tickets.dart';
import 'package:prepare_project/features/tour_guide/private_tour/presentation/view/widgets/model_bottom_create_edit.dart';

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
                const Text('title of the trip'),
                const SizedBox(height: 5,),
                CustomTextFormField(
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
                const Text('brief of the trip'),
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
            DetailsDayList(height: height, width: width,cubit: cubit,tripDays: cubit.tripDay,),
            const SizedBox(height: 20,),
            BGPrivateTourOption(height: height, cubit: cubit,width: width,),
            const SizedBox(height: 20,),
            MinPersonTicketPrice(width: width, minTicket: cubit.pricePerPersonTextController,minPerson: cubit.minimumPersonTextController,),
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
