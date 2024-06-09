import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';

class TicketWithShowInMap extends StatelessWidget {
  const TicketWithShowInMap({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height*0.07,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const Text('Ticket Price',style: CustomTextStyle.fontNormal14WithEllipsis,),
              Container(
                width: width*0.2,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(color: basicColor,borderRadius: commonBorderRadius(),),
                child:const Center(child:  Text('5 \$',style: CustomTextStyle.font16Light,)),
              )
            ],
          ),
          Container(
            width: width*0.5,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: basicColor,
              borderRadius: commonBorderRadius(),
            ),
            child:const Center(child: Text('Show in Map',style: CustomTextStyle.font16Light,),
            ),),
        ],
      ),
    );
  }
}