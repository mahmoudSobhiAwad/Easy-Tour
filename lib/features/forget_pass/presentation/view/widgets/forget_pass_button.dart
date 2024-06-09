import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';

import '../../../../../core/utilities/go_router/go_router.dart';

class ForgetPasswordButton extends StatelessWidget {
  const ForgetPasswordButton({
    super.key
  });
  @override
  Widget build(BuildContext context) {
    return  TextButton(
        autofocus: true,
        onPressed: (){
          context.push(RouterApp.kResetPasswordView);
        },child: Text('I’ve forgotten my password ',style: CustomTextStyle.font16Light.apply(decoration: TextDecoration.underline,decorationColor: secondaryColor)));
  }
}