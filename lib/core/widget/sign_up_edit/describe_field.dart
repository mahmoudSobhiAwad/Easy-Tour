import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';

class DescribeYourSelf extends StatelessWidget {
  const DescribeYourSelf({super.key,required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height :MediaQuery.of(context).size.height*0.11,
      child:  CustomTextFormField(
        controller: controller,
        label: 'Describe Yourself...',
        maxLines: 3,
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: formFillColor,
        border: 20,
      ),
    );
  }
}
