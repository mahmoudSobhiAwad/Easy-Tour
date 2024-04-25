import 'package:flutter/material.dart';

class CustomDropDownButton extends StatelessWidget {
  const CustomDropDownButton({
    super.key,
    required this.list,
    required this.onChanged,
    required this.maxHeight,
    this.maxWidth,
    this.style,
    this.iconSize,
    this.iconColor
  });

  final List<String>list;
  final void Function(String?value) onChanged;
  final double maxHeight;
  final double? maxWidth;
  final TextStyle? style;
  final double?iconSize;
  final Color?iconColor;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      constraints: BoxConstraints(
        maxHeight: maxHeight,
        maxWidth: maxWidth??double.infinity,
      ),
      onSelected: (String selectedGovernorate){
        onChanged(selectedGovernorate);
        //print("Selected governorate: $selectedGovernorate");
      },
      itemBuilder: (BuildContext context) {
        return list.map((String value) =>
            PopupMenuItem<String>(
              value: value,
              child: Text(value,style: style,),
            )
        ).toList();
      },
      child: RotatedBox(
          quarterTurns: 1,
          child: Icon(Icons.arrow_forward_ios,color: iconColor??Colors.white,size: iconSize,)), // Customize menu button icon
    );
  }
}