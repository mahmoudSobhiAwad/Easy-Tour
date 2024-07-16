import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/core/widget/sign_up_edit/custom_column_with_text_form.dart';
class AddressTextForm extends StatelessWidget {
  const AddressTextForm({super.key,required this.controller});
  final TextEditingController controller;
  @override

  Widget build(BuildContext context) {
    return CustomColumnWithTextForm(
      text: 'Home Address',customTextFormField: CustomTextFormField(
      maxLines: 1,
      type: TextInputType.streetAddress,
      label: '',fillColor: thirdColor,filled: true,border: 12,controller:controller ,),);
  }
}