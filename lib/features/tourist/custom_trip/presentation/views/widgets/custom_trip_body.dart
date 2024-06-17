import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/core/widget/sign_up_edit/custom_column_with_text_form.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_app_bar_trip_generated.dart';
import 'package:prepare_project/features/tourist/custom_trip/presentation/manager/custom_trip_cubit.dart';
import 'package:prepare_project/features/tourist/custom_trip/presentation/views/widgets/days_list_widget.dart';
import 'package:prepare_project/features/tourist/custom_trip/presentation/views/widgets/start_end_date.dart';
class CustomTripBody extends StatelessWidget {
  const CustomTripBody({
    super.key,
    required this.height,
    required this.width,
    required this.cubit,
  });

  final double height;
  final double width;
  final CustomTripCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomGeneratedAiTripAppBar(height: height, width: width,appBarTitle: cubit.editOrCreate?"Edit Trip":'Create A Trip',),
            SizedBox(height: height*0.02,),
            CustomColumnWithTextForm(text: 'Trip Title',maxLine: 1,
              customTextFormField: SizedBox(
                  width: width*0.6,
                  height: height*0.08,
                  child: CustomTextFormField(filled: true,border: 12,fillColor: thirdColor,maxLines: 1,controller: cubit.titleController,)),),
            SizedBox(height: height*0.02,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomColumnWithTextForm(text: 'Start Date',maxLine: 1,
                  customTextFormField: StartOrEndDate(width: width, height: height,text: cubit.startDate,),),
                CustomColumnWithTextForm(text: 'End Date',maxLine: 1,
                  customTextFormField: StartOrEndDate(width: width, height: height,text: cubit.endDate,),),
                IconButton(onPressed: ()async{
                  DateTimeRange? range= await showDateRangePicker(context: context, firstDate: DateTime.now(), lastDate:DateTime.now().add(const Duration(days: 10)),);
                  cubit.changePickedDate(range);
                }, padding: const EdgeInsets.only(top: 20),icon:const FaIcon(FontAwesomeIcons.calendarDays)),
              ],
            ),
            SizedBox(height: height*0.02,),
            DaysToAddList(width: width, height: height,tripsDetailsList: cubit.pickedCompleteTrip.tripDetailsList??[],cubit: cubit,),
            SizedBox(height: height*0.02,),
            Center(child: CustomLoginButton(label: cubit.editOrCreate?"Edit Trip":'Create Trip',altWidth: width*0.4,onTap: (){
             cubit.editOrCreate?cubit.editCustomTrip(): cubit.createCustomTrip();
            },),),
          ],
        ),
      ),
    );
  }
}
