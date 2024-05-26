import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
class ServicesFacilitiesItem extends StatelessWidget {
  const ServicesFacilitiesItem({super.key});

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
        Text('Swimming Pool',style: CustomTextStyle.commonFontThinLight.copyWith(fontSize: 12),),
      ],
    );
  }
}
