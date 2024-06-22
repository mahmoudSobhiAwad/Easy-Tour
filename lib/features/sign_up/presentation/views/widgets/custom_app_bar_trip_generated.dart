import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
class CustomGeneratedAiTripAppBar extends StatelessWidget {
  const CustomGeneratedAiTripAppBar({super.key,this.backDirect=true,this.extraOnBack,this.borderColor,this.bgColor,this.appBarStyle,this.showBackIcon=true,required this.height,this.appBarTitle,required this.width,this.menuToSaveTrip,this.appBarWidth});
  final double height;
  final double width;
  final double? appBarWidth;
  final String? appBarTitle;
  final Widget?menuToSaveTrip;
  final bool showBackIcon;
  final TextStyle? appBarStyle;
  final Color? bgColor;
  final Color? borderColor;
  final void Function()?extraOnBack;
  final bool backDirect;
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: height*0.1,
      width:width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          showBackIcon?
          CustomContainerWithStroke(
            bgColor: bgColor,
            borderColor: borderColor,
            containWidget: const Icon(Icons.arrow_back_sharp,),
            height: height, width: width,
            onTap: backDirect?(){
              Navigator.pop(context);}:extraOnBack,
          ):
          SizedBox(width: width*0.13,),
          const Expanded(child: SizedBox(width: 5,)),
          appBarTitle==null?const SizedBox():SizedBox(
              width: appBarWidth,
              child: Text('$appBarTitle',style:appBarStyle??CustomTextStyle.fontGrover30.copyWith(fontSize: 28,),maxLines: 2,textAlign: TextAlign.center,)),
          const Expanded(child: SizedBox(width: 5,)),
          menuToSaveTrip??const Expanded(child: SizedBox(width: 5,)),
        ],
      ),
    );
  }
}

class CustomContainerWithStroke extends StatelessWidget {
  const CustomContainerWithStroke({
    super.key,
    required this.height,
    required this.width,
    this.onTap,
    required this.containWidget,
    this.borderColor,
    this.bgColor,
  });

  final double height;
  final double width;
  final void Function()?onTap;
  final Widget containWidget;
  final Color? borderColor;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height:height*0.1,
      width:width*0.13,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: bgColor??Colors.white,
          boxShadow: [buildBoxShadow()],
          border: Border.all(color: borderColor??secondaryColor,width: 3)
      ),
      child:GestureDetector(
          onTap: onTap,
          child: containWidget
      ),
    );
  }
}