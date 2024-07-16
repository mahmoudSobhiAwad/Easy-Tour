import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/sign_up_edit/custom_column_with_text_form.dart';
class EmptyDayToAddItem extends StatelessWidget {
  const EmptyDayToAddItem({super.key,required this.width});
  final double width;
  @override
  Widget build(BuildContext context) {
    return CustomColumnWithTextForm(
      customTextFormField: Container(
        width: width,
        decoration: BoxDecoration(
          color: thirdColor,
          border: Border.all(color: secondaryColor,),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(15),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child:  ColoredBox(color: secondaryColor,child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Push To Pick Places To You Trip',style: CustomTextStyle.fontNormal16,textAlign: TextAlign.center,),
            ),)),
      ),
    );
  }
}