import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
class SignUpStepsNames extends StatelessWidget {
  const SignUpStepsNames({super.key,this.stepsNames});
final List<String>?stepsNames;
  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        stepsNames?.length??0,
            (index) {
          return Text(stepsNames![index],style:const TextStyle(color: basicColor,fontSize: 14,fontWeight: FontWeight.bold),);
        }),

    );
  }
}
