import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';

class DateFormField extends StatelessWidget {
  const DateFormField({super.key,required this.controller,required this.width});
final TextEditingController controller;
final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width :width*0.43,
        child:  CustomTextFormField(
          maxLines: 1,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          controller: controller,
          suffix: IconButton(
              onPressed:()async{
                controller.text=await showDatePickerDialog(context)??"";
              },
              icon: const Icon(Icons.calendar_month_rounded,color: basicColor,)),
          label: '10-10-2000',
          fillColor: formFillColor,
          filled: true,border: 20,));
  }
}
Future<String?> showDatePickerDialog(BuildContext context) async {
  final DateTime? pickedDate = await showDatePicker(
    context: context, initialDate: DateTime(1999), firstDate: DateTime(1970), lastDate: DateTime(2002)
  );

  if (pickedDate != null) {
    final DateTime dateTime = pickedDate;
    String formattedTime = DateFormat('yyyy-MM-dd').format(dateTime);
    return formattedTime;

  }
  return null;
}

