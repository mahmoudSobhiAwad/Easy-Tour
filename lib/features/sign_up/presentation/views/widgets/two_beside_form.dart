//first widget that contain first name and last name
import 'package:flutter/material.dart';
import 'package:prepare_project/core/widget/sign_up_edit/custom_column_with_text_form.dart';

class CustomTwoFieldForm extends StatelessWidget {
  const CustomTwoFieldForm({super.key,this.firstText,this.secondText,this.firstCustomFormField,this.secondCustomFormField});
  final String?firstText;
  final String?secondText;
  final Widget?firstCustomFormField;
  final Widget?secondCustomFormField;
  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomColumnWithTextForm(
          text: firstText,
          customTextFormField: firstCustomFormField,
        ),
        CustomColumnWithTextForm(
          text: secondText,
          customTextFormField: secondCustomFormField,
        ),
      ],
    );
  }
}