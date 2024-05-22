import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/available_rooms/availabile_room_view.dart';

class TextDetailsOfOneHotel extends StatelessWidget {
  const TextDetailsOfOneHotel({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            width: width*0.4,
            child: const Text('Davinci Beach Hotel',style: CustomTextStyle.privateTourTitle,maxLines: 2,)),
        Row(
          children: [
            ...List.generate(5, (index) {
              return const Padding(
                padding:  EdgeInsets.only(left: 5.0),
                child:  Icon(Icons.star,color: goldenColor,),
              );
            }),
          ],
        ),
        SizedBox(height: height*0.01,),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.location_on_rounded),
            Text('Luxor, Kasr El Montazah',style: CustomTextStyle.commonFontThin,),
          ],),
        SizedBox(height: height*0.01,),
        const Text('Business Hotel, Family Hotel',style: CustomTextStyle.commonFontThin,),
        SizedBox(height: height*0.01,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.check,color: whatsAppColor,),
            Text('BED AND BREAKFAST',style: CustomTextStyle.tripDetailsInTourGuide.copyWith(color: whatsAppColor),),
          ],),
        SizedBox(height: height*0.01,),
        const Text('2 adult, 3 nights',style: CustomTextStyle.commonFontThinLight,),
        SizedBox(height: height*0.01,),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: GestureDetector(
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder:(context){
                return const RoomAvailabilityView();
              }));
            },
            child: const ColoredBox(
              color: forthColor,
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Text('See Availability Rooms',style: CustomTextStyle.commonSignThinAlwaysWhite,),
                    Icon(Icons.arrow_forward,color: Colors.white,),
                  ],
                ),
              ),),
          ),
        ),
      ],
    );
  }
}