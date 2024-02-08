import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
class NameTextFormField extends StatelessWidget {
  const NameTextFormField({
    super.key,
     this.nameController,
  });

  final TextEditingController ?nameController;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1),blurRadius:4 ,offset:const Offset(0,2))
          ]
      ),
      child: CustomTextFormField(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        filled: true,
        fillColor: Colors.white,
        enableOutLine: true,
        prefix:const Icon(Icons.person,color: secondaryColor,),
        label: 'UserName',
        controller: nameController,
      ),
    );
  }
}