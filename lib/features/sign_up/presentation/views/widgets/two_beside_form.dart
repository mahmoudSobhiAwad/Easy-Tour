//first widget that contain first name and last name
import 'package:flutter/material.dart';
import 'package:prepare_project/core/widget/sign_up_edit/custom_column_with_text_form.dart';

class CustomTwoFieldForm extends StatelessWidget {
  const CustomTwoFieldForm({super.key,this.mainAlignment,this.firstText,this.textHeight,this.textWidth,this.secondText,this.firstCustomFormField,this.maxLine,this.secondCustomFormField});
  final String?firstText;
  final String?secondText;
  final Widget?firstCustomFormField;
  final Widget?secondCustomFormField;
  final int?maxLine;
  final double? textWidth;
  final double? textHeight;
  final MainAxisAlignment? mainAlignment;
  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: mainAlignment??MainAxisAlignment.spaceBetween,
      children: [
        CustomColumnWithTextForm(
          textHeight: textHeight,
          textWidth: textWidth,
          maxLine: maxLine,
          text: firstText,
          customTextFormField: firstCustomFormField,
        ),
        CustomColumnWithTextForm(
          textHeight: textHeight,
          textWidth: textWidth,
          maxLine: maxLine,
          text: secondText,
          customTextFormField: secondCustomFormField,
        ),
      ],
    );
  }
}