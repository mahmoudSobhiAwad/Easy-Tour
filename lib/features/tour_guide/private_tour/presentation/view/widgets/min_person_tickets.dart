import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/two_beside_form.dart';

class MinPersonTicketPrice extends StatelessWidget {
  const MinPersonTicketPrice({
    super.key,
    required this.width,
    required this.minTicket,
    required this.minPerson
  });

  final double width;
  final TextEditingController minTicket;
  final TextEditingController minPerson;

  @override
  Widget build(BuildContext context) {
    return CustomTwoFieldForm(
      firstCustomFormField:SizedBox(
        width: width*0.43,
        child: CustomTextFormField(
          border: 20,
          fillColor: thirdColor,
          filled: true,
          enableOutLine: false,
          type: const TextInputType.numberWithOptions(decimal: true),
          controller: minTicket,
          suffix:SizedBox(
              width: width*0.25,
              child: const Padding(
                padding: EdgeInsets.only(right: 5.0),
                child: Align(alignment: Alignment.centerRight,child: Text('\$ For Each',)),
              )),
        ),
      ),
      secondCustomFormField: SizedBox(
        width: width*0.43,
        child: CustomTextFormField(
          border: 20,
          fillColor: thirdColor,
          filled: true,
          enableOutLine: false,
          type: const TextInputType.numberWithOptions(decimal: true),
          controller: minPerson,
          suffix:SizedBox(
              width: width*0.25,
              child: const Padding(
                padding: EdgeInsets.only(right: 5.0),
                child: Align(alignment: Alignment.centerRight,child: Text('min person',)),
              )),
        ),
      ),
    );
  }
}