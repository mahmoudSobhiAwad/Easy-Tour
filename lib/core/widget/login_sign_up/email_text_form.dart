import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';

import 'custom_text_form.dart';

class EmailTextFormField extends StatelessWidget {
  const EmailTextFormField({
    super.key,this.emailTextEditingController,this.emailFocusNode,this.passFocusNode});
  final TextEditingController? emailTextEditingController;
  final FocusNode? emailFocusNode;
  final FocusNode? passFocusNode;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1),blurRadius:4 ,offset:const Offset(0,2))
        ]
      ),
      child: CustomTextFormField(
        type: TextInputType.emailAddress,
        onFiledSubmitted: (value){
         FocusScope.of(context).requestFocus(passFocusNode);
        },
        focusNode:emailFocusNode ,
        fillColor: Colors.white,
        filled: true,
        enableOutLine: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        prefix:const  Icon(Icons.email,color: secondaryColor,),
        label: 'Email Address',
        controller: emailTextEditingController,
      ),
    );
  }
}