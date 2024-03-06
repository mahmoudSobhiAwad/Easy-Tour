import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
class PhoneFormField extends StatelessWidget {
  const PhoneFormField({super.key,this.controller,this.initialValue,required this.width});
  final TextEditingController? controller;
  final String?initialValue;
  final double width;
 @override
  Widget build(BuildContext context) {
    return SizedBox(
        width :width*0.43,
        child:  CustomTextFormField(
          maxLines: 1,
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(r'^0')), // Deny leading 0
          ],
          type:const TextInputType.numberWithOptions(),
          controller: controller,
          prefix: Padding(
            padding: const EdgeInsets.only(left: 5,top: 15,bottom: 15,right: 10),
            child: Container(
              width: 50,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: basicColor),
              child: const Center(child: Text('+20',style: TextStyle(color: Colors.white),)),
            ),
          ),
          fillColor: thirdColor,
          filled: true,
          border: 20,)
    );
  }
}

