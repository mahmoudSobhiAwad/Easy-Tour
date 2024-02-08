import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/widget/login_sign_up/sign_up_step_names.dart';

class CustomLinearProgressIndicator extends StatelessWidget {
  const CustomLinearProgressIndicator({super.key,this.stepsNames,this.index});
  final List<String>?stepsNames;
  final int?index;
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width*.9;
    return Column(
      children: [
        SignUpStepsNames(stepsNames: stepsNames,),
        const SizedBox(height:5),
        Stack(
          children: [
            Container(
              height: 10,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: secondaryColor),
              ),
            ),
            Container(
              height: 10,width:((index)!+1)*width/(stepsNames!.length),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: basicColor
              ),),
          ],
        ),
      ],
    );
  }
}
