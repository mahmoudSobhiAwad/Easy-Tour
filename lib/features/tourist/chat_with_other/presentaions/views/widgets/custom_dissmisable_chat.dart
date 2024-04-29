import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
class CustomDismissible extends StatelessWidget {
  const CustomDismissible({
    super.key,
    required this.child,
  });

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.startToEnd,
      background: Container(
        decoration: BoxDecoration(
          color: closeColor,
          borderRadius: commonBorderRadius(),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        alignment: Alignment.centerLeft,
        child:const Padding(
          padding:  EdgeInsets.only(left: 10.0),
          child:  Icon(
            size:30,
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      // onDismissed:(_){} ,
      key: UniqueKey(),
      child: child,
    );
  }
}