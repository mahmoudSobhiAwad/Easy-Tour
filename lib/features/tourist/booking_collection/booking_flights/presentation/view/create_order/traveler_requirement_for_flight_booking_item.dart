import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/view/create_order/document_data.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/view/create_order/issuance_data.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/view/create_order/traveler_data.dart';
class TravelerRequirementsForFlightBookingItem extends StatelessWidget {
  const TravelerRequirementsForFlightBookingItem({super.key,required this.width,required this.height});
  final double width;
  final double height;
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
            const Text('Traveler 1',style: CustomTextStyle.fontBold14,),
            SizedBox(height: height*0.01,),
            TravelerData(width: width, height: height),
            SizedBox(height: height*0.01,),
            DocumentData(height: height, width: width),
            SizedBox(height: height*0.01,),
            IssuanceData(width: width, height: height),
            SizedBox(height: height*0.01,),
            Row(
              children: [
                const Text('Are you the holder ?',style: CustomTextStyle.fontBold16,),
                SizedBox(width: width*0.1,),
                ...List.generate(2, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: thirdColor),
                      ),
                      child: const CircleAvatar(
                        backgroundColor: whatsAppColor,
                        radius: 10,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}