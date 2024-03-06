import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';

class CustomColumnWithTextForm extends StatelessWidget {
  const CustomColumnWithTextForm({super.key,this.textWidth,this.textHeight,this.text,this.customTextFormField,this.align,this.style,this.maxLine});
  final String?text;
  final Widget? customTextFormField;
  final TextStyle? style;
  final int? maxLine;
  final TextAlign? align;
  final double?textWidth;
  final double?textHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:CrossAxisAlignment.start,
      children: [
        text!=null ? Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: SizedBox(
              width: textWidth,
              height: textHeight,
              child: Text(text??"",style:style??CustomTextStyle.commonSignDark,maxLines: maxLine,textAlign: align,)),
        ):
        const SizedBox(),
        const SizedBox(height: 5,),
        customTextFormField!,
      ],
    );
  }
}