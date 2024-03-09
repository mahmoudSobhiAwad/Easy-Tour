import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'custom_text_form.dart';

class PasswordTextFormField extends StatelessWidget {
  const PasswordTextFormField({
    super.key,
   required this.enablePassword,
   required this.passwordController,
   required this.changeShowing,
    this.height,
    this.passFocusNode,
  });

  final void Function()?changeShowing;
  final bool enablePassword;
  final double?height;
  final TextEditingController?passwordController;
  final FocusNode? passFocusNode;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      maxLines: 1,
      focusNode: passFocusNode,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      filled: true,
      fillColor: Colors.white,
      enableOutLine: true,
      label: 'Password',
      enablePassword: enablePassword,//cubit.showPassword
      prefix: const Icon(Icons.lock_outline,color: secondaryColor,),
      suffix: IconButton(
        onPressed:changeShowing,
          icon:enablePassword
          ? const Icon(Icons.visibility_off,color: basicColor,)
          :const Icon(Icons.visibility,color: basicColor,),),
      controller: passwordController,

    );
  }
}