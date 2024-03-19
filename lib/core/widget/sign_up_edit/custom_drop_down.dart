import 'package:flutter/material.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';

import 'package:prepare_project/core/utilities/basics.dart';

class CustomDropDownMenu extends StatelessWidget {
  const CustomDropDownMenu({super.key,this.labelStyle,this.label,this.fontSize,this.width,this.fillColor,this.list,this.onSelected,this.initialValue,this.color,this.enableSearch});
  final List<String>?list;
  final  void Function(String?)? onSelected;
  final String?initialValue;
  final Color?color;
 final bool? enableSearch;
 final double?width;
 final Color?fillColor;
 final String?label;
 final double?fontSize;
 final TextStyle? labelStyle;
  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      label:Text(label??'',style:labelStyle??const TextStyle(fontSize: 8),) ,
      width: width,
      menuHeight: 150,
      enableSearch: enableSearch??false,
      inputDecorationTheme: InputDecorationTheme(
        floatingLabelBehavior: FloatingLabelBehavior.never,
          fillColor: fillColor??formFillColor,
          filled: true,
        enabledBorder: const CustomTextFormField().buildOutlineInputBorder(borderColor: secondaryColor.withOpacity(0.7),borderRadius: 20) ,
      ),
      onSelected: onSelected,
      menuStyle: const MenuStyle(backgroundColor: MaterialStatePropertyAll(Colors.white)),
      initialSelection: initialValue,
      textStyle: TextStyle(color:color?? basicColor,fontSize: fontSize),
      trailingIcon: RotatedBox(
          quarterTurns: -1,
          child: Icon(Icons.arrow_back_ios_new,color: color,)),
      selectedTrailingIcon: RotatedBox(
          quarterTurns: 1,
          child: Icon(Icons.arrow_back_ios_new,color: color,)),
      dropdownMenuEntries:
      list!.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),);
  }
}
