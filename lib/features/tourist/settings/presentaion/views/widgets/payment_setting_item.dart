import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';

import '../../../../../../core/utilities/basics.dart';

class ProfileSettingItem extends StatelessWidget {
  const ProfileSettingItem({super.key,this.text,required this.child,this.height,this.onTap,this.rightWidget});
  final String?text;
  final Widget?child;
  final Widget?rightWidget;
  final double?height;
  final void Function()?onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  rightWidget??Text(text??"",style: CustomTextStyle.commonSignThinDark,),
                  child??const SizedBox(),
                ],

              ),
            ),
          ),
          const Divider(
            thickness: 1.5,
            color: thirdColor,
          ),
        ],
      ),
    );
  }
}