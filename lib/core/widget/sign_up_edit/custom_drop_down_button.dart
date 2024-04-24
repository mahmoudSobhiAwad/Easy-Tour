import 'package:flutter/material.dart';

class CustomDropDownButton extends StatelessWidget {
  const CustomDropDownButton({
    super.key,
    required this.list,
    required this.onChanged,
    required this.maxHeight,
    this.style
  });

  final List<String>list;
  final void Function(String?value) onChanged;
  final double maxHeight;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      constraints: BoxConstraints(
        maxHeight: maxHeight
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
      child: const RotatedBox(
          quarterTurns: 1,
          child: Icon(Icons.arrow_forward_ios,color: Colors.white,)), // Customize menu button icon
    );
  }
}