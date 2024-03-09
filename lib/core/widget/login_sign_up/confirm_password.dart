import 'package:flutter/material.dart';
import '../../utilities/basics.dart';
import 'custom_text_form.dart';
class ConfirmPasswordTextFormField extends StatelessWidget {
  const ConfirmPasswordTextFormField({
    super.key,
    required this.showConfirmPassword,
    this.confirmPasswordTextEditingController,
    this.changeConfirmShowing,
    this.height,
    this.borderColor,
     this.onChangeConfirm,
  });
  final Color? borderColor;
  final void Function()?changeConfirmShowing;
  final bool showConfirmPassword;
  final double?height;
  final TextEditingController?confirmPasswordTextEditingController;
  final void Function(String?value)?onChangeConfirm;
  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      maxLines: 1,
      onChanged:onChangeConfirm,
      borderColor: borderColor,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      filled: true,
      fillColor: Colors.white,
      enableOutLine: true,
      label: 'confirm Password',
      prefix: const Icon(Icons.lock_outline,color: secondaryColor,),
      suffix: IconButton(
        onPressed:(){
          changeConfirmShowing!();
        },
        icon:showConfirmPassword ? const Icon(Icons.visibility_off,color: basicColor,) :
        const Icon(Icons.visibility,color: basicColor,),),
      enablePassword:showConfirmPassword,
      controller:confirmPasswordTextEditingController,
    );
  }
}