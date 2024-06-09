import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/models/get_hotel_model.dart';

class TextDetailsOfOneHotel extends StatelessWidget {
  const TextDetailsOfOneHotel({
    super.key,
    required this.width,
    required this.height,
    required this.model,
    required this.onTap,
  });

  final double width;
  final double height;
final HotelsModel model;
final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            width: width*0.5,
            child: Text(model.name??"",style: CustomTextStyle.fontBold21,maxLines: 2,)),
        Row(
          children: [
            ...List.generate(model.categoryCode??3, (index) {
              return const Padding(
                padding:  EdgeInsets.only(left: 5.0),
                child:  Icon(Icons.star,color: goldenColor,),
              );
            }),
          ],
        ),
        SizedBox(height: height*0.01,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.location_on_rounded),
            SizedBox(
                width: width*0.5,
                child: Text('${model.cityName},${model.address}',style: CustomTextStyle.fontNormal14WithEllipsis,maxLines: 3,)),
          ],),
        SizedBox(height: height*0.01,),
        const Text('Business Hotel, Family Hotel',style: CustomTextStyle.fontNormal14WithEllipsis,),
        SizedBox(height: height*0.01,),
        Column(
          children: [
            ...List.generate(model.segment?.length??0, (index) =>Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.check,color: whatsAppColor,),
                Text(model.segment?[index].content??"",style: CustomTextStyle.font12WithEllipsis.copyWith(color: whatsAppColor),),
              ],), ),
          ],
        ),
        SizedBox(height: height*0.01,),
        const Text('2 adult, 3 nights',style: CustomTextStyle.font14Light,),
        SizedBox(height: height*0.01,),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: GestureDetector(
            onTap: onTap,
            child: const ColoredBox(
              color: forthColor,
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Text('See Availability Rooms',style: CustomTextStyle.font16NormalWhite,),
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