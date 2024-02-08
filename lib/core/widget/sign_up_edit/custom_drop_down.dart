import 'package:flutter/material.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';

import 'package:prepare_project/core/utilities/basics.dart';

class CustomDropDownMenu extends StatelessWidget {
  const CustomDropDownMenu({super.key,this.label,this.fontSize,this.width,this.fillColor,this.list,this.onSelected,this.initialValue,this.color,this.enableSearch});
  final List<String>?list;
  final  void Function(String?)? onSelected;
  final String?initialValue;
  final Color?color;
 final bool? enableSearch;
 final double?width;
 final Color?fillColor;
 final String?label;
 final double?fontSize;
  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      label:Text(label??'',style:const TextStyle(fontSize: 8),) ,
      width: width,
      menuHeight: 150,
      enableSearch: enableSearch??false,
      inputDecorationTheme: InputDecorationTheme(
          fillColor: fillColor??formFillColor,
          filled: true,
        enabledBorder: const CustomTextFormField().buildOutlineInputBorder(borderColor: secondaryColor.withOpacity(0.7),borderRadius: 20) ,
      ),
      onSelected: onSelected,
      initialSelection: initialValue,
      textStyle: TextStyle(color: basicColor,fontSize: fontSize),
      trailingIcon: const Icon(Icons.arrow_drop_down,),
      dropdownMenuEntries:
      list!.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),);
  }
}
