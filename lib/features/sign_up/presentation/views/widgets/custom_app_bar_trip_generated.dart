import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
class CustomGeneratedAiTripAppBar extends StatelessWidget {
  const CustomGeneratedAiTripAppBar({super.key,required this.height,this.appBarTitle,required this.width,this.menuToSaveTrip});
  final double height;
  final double width;
  final String? appBarTitle;
  final Widget?menuToSaveTrip;
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: height*0.1,
      width:width ,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height:height*0.1,
            width:width*0.13,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [buildBoxShadow()],
                border: Border.all(color: secondaryColor,width: 3)
            ),
            child: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back_sharp,color: basicColor,)),
          ),
          const Expanded(child: SizedBox(width: 5,)),
          appBarTitle==null?const SizedBox():Text('$appBarTitle',style: CustomTextStyle.homePartTitle.copyWith(fontSize: 28),),
          const Expanded(child: SizedBox(width: 5,)),
          menuToSaveTrip??const Expanded(child: SizedBox(width: 5,)),
        ],
      ),
    );
  }
}