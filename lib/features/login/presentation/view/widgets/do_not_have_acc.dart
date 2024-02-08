import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';

class DoNotHaveAcc extends StatelessWidget {
  const DoNotHaveAcc({super.key,this.onPressed,this.content,this.buttonText});
final String? content;
final String?buttonText;
final void Function()? onPressed;
@override
Widget build(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
       Text(content??'',style:CustomTextStyle.commonSignLight),
      TextButton(onPressed: onPressed, child: Text(buttonText??'',style:CustomTextStyle.commonSignDark),),
    ],
  );
}
}





