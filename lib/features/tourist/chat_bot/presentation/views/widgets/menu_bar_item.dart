import 'package:flutter/material.dart';

import '../../../../../../core/utilities/textStyle/font_styles.dart';

class MenuItemAppBarButton extends StatelessWidget {
  const MenuItemAppBarButton({super.key,required this.text,required this.icon});
  final String text;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text,style: CustomTextStyle.fontNormal14WithEllipsis,),
        icon,
      ],
    );
  }
}