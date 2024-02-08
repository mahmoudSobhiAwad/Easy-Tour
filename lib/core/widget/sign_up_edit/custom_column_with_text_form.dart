import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';

class CustomColumnWithTextForm extends StatelessWidget {
  const CustomColumnWithTextForm({super.key,this.text,this.customTextFormField});
  final String?text;
  final Widget? customTextFormField;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text!=null ? Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(text??"",style:CustomTextStyle.commonSignDark),
        ):
        const SizedBox(),
        const SizedBox(height: 5,),
        customTextFormField!,
      ],
    );
  }
}