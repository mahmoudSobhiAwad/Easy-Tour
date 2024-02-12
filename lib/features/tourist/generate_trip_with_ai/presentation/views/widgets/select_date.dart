import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
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
      height: height*0.14,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Select Date To Start Your Trip',style: CustomTextStyle.commonSignDark,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding:const EdgeInsets.all(10),
                width: width*0.55,
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
                      width: width*0.35,
                      child:cubit.numOfDay==null? const Text('Pick Range Of Date',style: CustomTextStyle.commonFontThin,):Text('From: ${cubit.firstPickedDay}\nTo : ${cubit.lastPickedDay}\nNumber of days :${cubit.numOfDay}',style: CustomTextStyle.commonFontThin,),
                    ),
                    IconButton(onPressed:(){
                      cubit.getRangeDate(context);
                      }, padding: EdgeInsets.zero,icon:const Icon(Icons.calendar_month_rounded,color: Colors.black,))
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: height*0.05,
                  padding:const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    boxShadow: [buildBoxShadow()],
                    color: thirdColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:const Row(
                    children: [
                      Icon(Icons.history),
                      Text('Previous Trips',style: CustomTextStyle.commonFontThin,)
                    ],),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}