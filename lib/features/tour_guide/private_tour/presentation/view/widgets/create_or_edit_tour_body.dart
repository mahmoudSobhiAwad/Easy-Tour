import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/two_beside_form.dart';
import 'package:prepare_project/features/tour_guide/private_tour/presentation/manager/edit_create_tour/edit_create_tour_cubit.dart';
import 'package:prepare_project/features/tour_guide/private_tour/presentation/view/widgets/bg_tour.dart';
import 'package:prepare_project/features/tour_guide/private_tour/presentation/view/widgets/details_day_list.dart';

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
    return Padding(
      padding: EdgeInsets.only(left: 20.0,right: 20,top: height*0.03,),
      child: SingleChildScrollView(
        child: Column(
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
            CustomTwoFieldForm(
              firstCustomFormField:SizedBox(
                width: width*0.43,
                child: CustomTextFormField(
                  border: 20,
                  fillColor: thirdColor,
                  filled: true,
                  enableOutLine: false,
                  type: TextInputType.number,
                  controller: cubit.pricePerPersonTextController,
                  suffix:SizedBox(
                    width: width*0.25,
                      child: const Padding(
                        padding: EdgeInsets.only(right: 5.0),
                        child: Align(alignment: Alignment.centerRight,child: Text('\$ For Each',)),
                      )),
                ),
              ),
              secondCustomFormField: SizedBox(
                width: width*0.43,
                child: CustomTextFormField(
                  border: 20,
                  fillColor: thirdColor,
                  filled: true,
                  enableOutLine: false,
                  type: const TextInputType.numberWithOptions(decimal: true),
                  controller: cubit.minimumPersonTextController,
                  suffix:SizedBox(
                      width: width*0.25,
                      child: const Padding(
                        padding: EdgeInsets.only(right: 5.0),
                        child: Align(alignment: Alignment.centerRight,child: Text('min person',)),
                      )),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            CustomLoginButton(
              label:switch(editOrCreate){
                // TODO: Handle this case.
                CreateOrEdit.create => 'Add',
                // TODO: Handle this case.
                CreateOrEdit.edit => 'Edit',
              },
              onTap:
                switch(editOrCreate){
                // TODO: Handle this case.
                  CreateOrEdit.create => (){
                    cubit.createNewTrip();
                  },
                // TODO: Handle this case.
                  CreateOrEdit.edit => (){
                    cubit.editCurrentTrip();
                  },
                }
            ),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
enum CreateOrEdit{create,edit}