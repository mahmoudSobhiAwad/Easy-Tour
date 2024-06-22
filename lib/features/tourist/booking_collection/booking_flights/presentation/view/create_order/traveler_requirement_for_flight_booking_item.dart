import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/manager/create_order/cubit.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/view/create_order/document_data.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/view/create_order/issuance_data.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/view/create_order/traveler_data.dart';
class TravelerRequirementsForFlightBookingItem extends StatelessWidget {
  const TravelerRequirementsForFlightBookingItem({super.key,required this.width,required this.height,required this.cubit,required this.index});
  final double width;
  final double height;
  final CreateFlightOrderCubit cubit;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width*0.9,
      decoration: BoxDecoration(
        border: Border.all(color: thirdColor,width: 3),
        borderRadius:BorderRadius.circular(12),
      ),
      padding:const EdgeInsets.all(7),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Traveler ${index+1}',style: CustomTextStyle.fontBold14,),
            SizedBox(height: height*0.01,),
            TravelerData(width: width, height: height,index: index,cubit: cubit,),
            SizedBox(height: height*0.01,),
            DocumentData(height: height, width: width,index: index,cubit: cubit,),
            SizedBox(height: height*0.01,),
            IssuanceData(width: width, height: height,cubit: cubit,index: index),
            SizedBox(height: height*0.01,),
          ],
        ),
      ),
    );
  }
}