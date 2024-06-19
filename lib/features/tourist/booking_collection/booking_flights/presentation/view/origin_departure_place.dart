import 'dart:math';

import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/core/widget/sign_up_edit/custom_column_with_text_form.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/data/flight_models/iata_codes_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/manager/get_ticket/cubit.dart';
class OriginAndDeparturePlace extends StatelessWidget {
  const OriginAndDeparturePlace({
    super.key,
    required this.width,
    required this.height,
    required this.cubit,
  });

  final double width;
  final double height;
  final GetTicketCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomColumnWithTextForm(
              text: 'From',
              customTextFormField: SizedBox(
                width: width*0.9,
                child: CustomTextFormField(
                  initialValue: cubit.fromPlace?.countryName??"",
                  onChanged: (value){
                    cubit.getListOfFromAirPortTextSearch(value);
                  },
                  border: 10,
                  prefix: Transform.rotate(
                      angle: 45*pi/180,
                      child:const Icon(Icons.airplanemode_on_outlined)),
                ),
              ),
            ),
            ResultListOfIatCodes(iatCodesList: cubit.fromIatCodesList, height: height, width: width),
            SizedBox(
              width: width*.9,
              child:  CustomColumnWithTextForm(
                text: 'To',
                customTextFormField: CustomTextFormField(
                  border: 10,
                  onChanged: (value){
                    cubit.getListOfToAirPortTextSearch(value);
                  },
                  initialValue: cubit.toPlace?.countryName??"",
                  prefix: Transform.rotate(
                      angle: 45 * pi / 180,
                      child: const Icon(Icons.airplanemode_on_outlined)),
                ),
              ),
            ),
          ],
        ),
        CircleAvatar(
          radius: width*0.07,
          backgroundColor: ticketBasicColor,
          child: IconButton(onPressed: (){
            cubit.swapBetweenFromTo();
          }, icon:const Icon(Icons.swap_vert_outlined,color: Colors.white,size: 40,)),
        ),
      ],
    );
  }
}
class ResultListOfIatCodes extends StatelessWidget {
  const ResultListOfIatCodes({super.key,required this.iatCodesList,required this.height,required this.width});
final List<IatCodeModel>iatCodesList;
final double width;
final double height;
  @override
  Widget build(BuildContext context) {
    return iatCodesList.isEmpty?
    const SizedBox():
    Container(
      width: width*0.4,
      height: height*0.15,
      decoration: BoxDecoration(
        color: thirdColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: secondaryColor,width: 2),
      ),
      child: ListView.separated(itemBuilder: (context,index){
        return TextButton(onPressed: null, child: Text('${iatCodesList[index].cityName}-${iatCodesList[index].countryName}',style: CustomTextStyle.fontBold14,maxLines: 2,overflow: TextOverflow.ellipsis,));
      }, separatorBuilder: (context,index){
        return const SizedBox(
          height: 5,
        );
      }, itemCount: iatCodesList.length),
    );
  }
}
