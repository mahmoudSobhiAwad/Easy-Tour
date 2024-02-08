import 'package:flutter/material.dart';

import '../../../../../../core/widget/login_sign_up/password_text_field.dart';

class OldPassword extends StatelessWidget {
  const OldPassword({
    super.key,
    required this.height,
    required this.title,
    required this.oldPassVis,
    required this.oldPassController,
    required this.changeOldVis,
  });

  final double height;
  final String title;
  final bool oldPassVis;
  final TextEditingController oldPassController;
  final void Function()?changeOldVis;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:height*0.14 ,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          PasswordTextFormField(
              height: height*0.1,
              enablePassword: oldPassVis,
              passwordController: oldPassController,
              changeShowing:changeOldVis,
          ),
        ],
      ),
    );
  }
}