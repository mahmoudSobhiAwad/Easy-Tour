import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
class DividerInRequestWidget extends StatelessWidget {
  const DividerInRequestWidget({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          width: width*0.75,
          child: Divider(color: entertainmentColor.withOpacity(0.6),thickness: 5,)),
    );
  }
}