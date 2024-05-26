import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/core/widget/sign_up_edit/custom_drop_down_button.dart';
class AmountConverterWidget extends StatelessWidget {
  const AmountConverterWidget({
    super.key,
    required this.height,
    required this.width,
    required this.list,
    this.enable=true,
    required this.currencyIcon,
    required this.currencyCode,
    required this.onChanged,
    required this.controller,
    this.onChangeInValue
  });

  final double height;
  final double width;
  final List<String>list;
  final bool enable;
  final String? currencyIcon;
  final String? currencyCode;
  final void Function(String value) onChanged;
  final TextEditingController controller;
  final void Function()?onChangeInValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(currencyIcon??"",style: const TextStyle(fontSize: 40),),
            Text(currencyCode??"",style:CustomTextStyle.commonSignDark),
            const SizedBox(width: 5,),
            CustomDropDownButton(list: list, onChanged: (value){
              onChanged(value!.substring(6));
            }, maxHeight: height*0.2,iconColor: entertainmentColor,maxWidth: width*0.7,style: const TextStyle(fontSize: 16),),
          ],
        ),
        SizedBox(
            width: width*0.4,
            child:CustomTextFormField(
              onChanged: (String?value){
                if(enable){
                  onChangeInValue!();
                }
              },
              style: CustomTextStyle.commonSignDark,
              controller:controller ,
              enable: enable,
              filled: true,
              enableOutLine: false,
              fillColor: thirdColor,border: 20,type: TextInputType.number,)),
      ],
    );
  }
}
