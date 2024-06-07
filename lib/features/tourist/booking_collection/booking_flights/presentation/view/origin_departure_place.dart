import 'dart:math';

import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/core/widget/sign_up_edit/custom_column_with_text_form.dart';
class OriginAndDeparturePlace extends StatelessWidget {
  const OriginAndDeparturePlace({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomColumnWithTextForm(
              text: 'From',
              customTextFormField: SizedBox(
                width: width*0.9,
                child: CustomTextFormField(
                  border: 10,
                  prefix: Transform.rotate(
                      angle: 45*pi/180,
                      child:const Icon(Icons.airplanemode_on_outlined)),
                ),
              ),
            ),
            SizedBox(
              width: width*.9,
              child:  CustomColumnWithTextForm(
                text: 'To',
                customTextFormField: CustomTextFormField(
                  border: 10,
                  prefix: Transform.rotate(
                      angle: 45 * pi / 180,
                      child: const Icon(Icons.airplanemode_on_outlined)),
                ),
              ),
            ),
          ],
        ),
        CircleAvatar(
          radius: width*0.07,
          backgroundColor: ticketBasicColor,
          child: const IconButton(onPressed: null, icon: Icon(Icons.swap_vert_outlined,color: Colors.white,size: 40,)),
        ),
      ],
    );
  }
}