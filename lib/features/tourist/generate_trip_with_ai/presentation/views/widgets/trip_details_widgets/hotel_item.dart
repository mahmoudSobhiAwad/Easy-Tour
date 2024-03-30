import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
class HotelItemInGeneratedTrip extends StatelessWidget {
  const HotelItemInGeneratedTrip({super.key,required this.height,required this.width});
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    const String imageUrl='https://www.holderhotelfurniture.com/wp-content/uploads/2020/10/hotel-furniture12-10-1024x684.jpg';
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          width: width*0.6,
          padding: EdgeInsets.symmetric(vertical: height*0.01,horizontal: width*0.0125),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: commonBorderRadius(),
            border: Border.all(color: thirdColor,width: 3),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                  child: Image.network(imageUrl,width: width*0.58,fit: BoxFit.fill,height: height*0.15,)),
              const Text('Spring Hotel Luxor',style: CustomTextStyle.commonSignDark,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.location_on_rounded,color: basicColor,),
                  Text('Luxor',style: CustomTextStyle.commonFontThin,),
                ],
              ),
              const Divider(height: 3,color: thirdColor,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('58\$ Per Night '),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: thirdColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(

                      children: [
                        Icon(Icons.star,color: Colors.orangeAccent,),
                        Text('4.3',style: CustomTextStyle.commonFontThin,),
                      ],
                    ),
                  )
                ],)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0,right: 12),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(color:thirdColor,width: 2 ),
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.open_in_new,color: basicColor,),
          ),
        )
      ],
    );
  }
}