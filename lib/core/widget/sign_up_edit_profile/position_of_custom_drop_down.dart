import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/widget/sign_up_edit_profile/custom_drop_down_list.dart';
class PositionOfCustomDropDown extends StatelessWidget {
  const PositionOfCustomDropDown({
    super.key,
    required this.items,
    required this.height,
    required this.width,
    required this.addPref,
    this.leftWidth,
    this.bottomHeight,
  });

  final double? bottomHeight;
  final double? leftWidth;
  final double width;
  final double height;
  final void Function(String?) addPref;
  final List<String> items;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: bottomHeight??0*0.03,
      left: leftWidth??0*0.03,
      child: Container(

        height: height*0.15,
        width:width*0.5,
        decoration: BoxDecoration(
          border: Border.all(color:secondaryColor),
            borderRadius: BorderRadius.circular(12),
            color: thirdColor
        ),
        child: CustomDropDownList(items: items,height: height,addPref:(String?value)
        {
          addPref(value);
        }),
      ),
    );
  }
}