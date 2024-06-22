import 'dart:math';
import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/core/widget/sign_up_edit/custom_column_with_text_form.dart';
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
                  controller: cubit.fromController,
                  onChanged: (value){
                    cubit.getListOfFromAirPortTextSearch(value).then((value) {
                      if(cubit.fromIatCodesList.isNotEmpty){
                        showMenu(context: context,
                            constraints: BoxConstraints(maxHeight: height*0.15,maxWidth: width*0.6),
                            position: RelativeRect.fromLTRB(width*0.2,height*0.39,width*0.4,height*0.5),
                            items: [
                              ...List.generate(cubit.fromIatCodesList.length, (index) => PopupMenuItem(
                                  onTap: (){
                                    cubit.pickIatCodesFromAndTo(model: cubit.fromIatCodesList[index], from: true);
                                  },
                                  child: Text('${cubit.fromIatCodesList[index].countryName}-${cubit.fromIatCodesList[index].cityName}-${cubit.fromIatCodesList[index].airportCode}')))
                            ]
                        );
                      }
                    });
                  },
                  border: 10,
                  prefix: Transform.rotate(
                      angle: 45*pi/180,
                      child:const Icon(Icons.airplanemode_on_outlined)),
                ),
              ),
            ),
            SizedBox(
              width: width*.9,
              child:  CustomColumnWithTextForm(
                text: 'To',
                customTextFormField: CustomTextFormField(
                  border: 10,
                  controller: cubit.toController,
                  onChanged: (value){
                    cubit.getListOfToAirPortTextSearch(value).then((value){
                      if(cubit.toIatCodesList.isNotEmpty){
                        showMenu(context: context,
                            constraints: BoxConstraints(maxHeight: height*0.15,maxWidth: width*0.6),
                            position: RelativeRect.fromLTRB(width*0.2,height*0.5,width*0.4,height*0.45),
                            items: [
                              ...List.generate(cubit.toIatCodesList.length, (index) => PopupMenuItem(
                                  onTap: (){
                                    cubit.pickIatCodesFromAndTo(model: cubit.toIatCodesList[index], from: false);
                                  },
                                  child: Text('${cubit.toIatCodesList[index].countryName}-${cubit.toIatCodesList[index].cityName}-${cubit.toIatCodesList[index].airportCode}')))
                            ]
                        );
                      }
                    });
                  },
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