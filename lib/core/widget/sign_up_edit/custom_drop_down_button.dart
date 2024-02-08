import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';

class CustomDropDownButton extends StatelessWidget {
  const CustomDropDownButton({
    super.key,
    this.initialValue,
    required this.list,
  });

  final String? initialValue;
  final List<String>list;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      menuMaxHeight: 150,
      style: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: basicColor),
      value: initialValue,
      padding: EdgeInsets.zero,
      items:list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),);}).toList(),
      onChanged:(value){},
      icon: const Icon(Icons.arrow_drop_down,color: basicColor,size: 25,),);
  }
}