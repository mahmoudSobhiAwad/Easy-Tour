import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/core/widget/sign_up_edit/custom_column_with_text_form.dart';
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
      height: height*0.17,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Select Date To Start Your Trip',style: CustomTextStyle.commonSignDark,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:const EdgeInsets.all(10),
                width: width*0.5,

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
                    GestureDetector(onTap:(){
                      cubit.getRangeDate(context);
                      },child:const Icon(Icons.calendar_month_rounded,color: Colors.black,))
                  ],
                ),
              ),
              SizedBox(
                width: width*0.4,
                child:CustomColumnWithTextForm(
                  align: TextAlign.center,
                  maxLine: 2,
                  style: CustomTextStyle.commonFontThin,
                  text: 'Num of place in each day',
                  customTextFormField: SizedBox(
                    child: CustomTextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(1),
                      ],
                      controller: cubit.numberOfPlaceInDayController,
                      type: TextInputType.number,
                      prefix:const Icon(Icons.av_timer),
                ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}