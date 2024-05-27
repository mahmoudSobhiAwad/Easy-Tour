import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
class ServicesFacilitiesItem extends StatelessWidget {
  const ServicesFacilitiesItem({super.key,required this.facilityItem,required this.width,required this.height});
final String facilityItem;
final double width;
final double height;
  @override
  Widget build(BuildContext context) {
    return  Row(

      children: [
        const CircleAvatar(
          radius: 10,
          backgroundColor: whatsAppColor,
          child: Icon(Icons.check,color: Colors.white,size: 15,),
        ),
        const SizedBox(width: 5,),
        SizedBox(
            width: width*0.25,
            child: Text(facilityItem,style: CustomTextStyle.commonFontThinLight.copyWith(fontSize: 12),maxLines: 2,)),
      ],
    );
  }
}
