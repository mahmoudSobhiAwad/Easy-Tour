import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
TableRow buildTableRow (List<String>cells){
  return TableRow(children: [
    ...List.generate(cells.length, (index) => Padding(
      padding: const EdgeInsets.all(5.0),
      child: Text(cells[index],style: CustomTextStyle.font14Light,textAlign: TextAlign.center,),
    )),
  ]);
}

TableRow buildTableWithWidget (List<Widget>cells){
  return TableRow(children: [
    ...List.generate(cells.length, (index) => Padding(
      padding: const EdgeInsets.all(5.0),
      child: cells[index],
    )),
  ]);
}