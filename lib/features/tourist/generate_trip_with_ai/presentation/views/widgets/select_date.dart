import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/two_beside_form.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/manager/generate_trip_cubit.dart';
class SelectDateAndViewTripHistory extends StatelessWidget {
  const SelectDateAndViewTripHistory({
    super.key,
    required this.height,
    required this.width,
    required this.cubit,
  });

  final double height;
  final double width;
 final GenerateAiTripCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height*0.15,
      child: CustomTwoFieldForm(
        firstText: 'Start Date',
        firstCustomFormField:  Container(
          height: height*0.1,
          padding:const EdgeInsets.all(10),
          width: width*0.6,
          decoration: BoxDecoration(
            boxShadow: [
              buildBoxShadow()
            ],
            color: thirdColor,
            borderRadius: commonBorderRadius(),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: width*0.45,
                // child:cubit.numOfDay==null? const Text('Pick Range Of Date',style: CustomTextStyle.commonFontThin,):Text('From: ${cubit.firstPickedDay}\nTo : ${cubit.lastPickedDay}\nNumber of days :${cubit.numOfDay}',style: CustomTextStyle.commonFontThin,),
              ),
              GestureDetector(onTap:(){
                //cubit.getRangeDate(context);
                },
                  child:const Icon(Icons.calendar_month_rounded,color: Colors.black,))
            ],
          ),
        ),
        secondText: 'Previous Trips',
        secondCustomFormField: CircleAvatar(
          backgroundColor: thirdColor,
          radius: width*0.1,
          child: const IconButton(
              onPressed: null,
              iconSize: 35,
              icon: Icon(Icons.history,color: basicColor,)
          ),
        ),
      ),
    );
  }
}

