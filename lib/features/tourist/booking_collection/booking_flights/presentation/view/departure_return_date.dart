
import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/core/widget/sign_up_edit/custom_column_with_text_form.dart';
import 'package:prepare_project/features/tourist/settings/presentaion/views/widgets/custom_switch.dart';
class DepartureAndReturnDate extends StatelessWidget {
  const DepartureAndReturnDate({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomColumnWithTextForm(
              text: 'Departure Date',
              customTextFormField: SizedBox(
                width: width*0.6,
                child: const CustomTextFormField(
                  border: 10,
                  prefix: IconButton(onPressed: null, icon: Icon(Icons.date_range_outlined)),),
              ),),
            Column(
              children: [
                const Text('Return Date',style: CustomTextStyle.commonSignDark,),
                const SizedBox(height: 5,),
                CustomSwitch(active: true, height: height, width: width),
              ],
            ),
          ],
        ),
        SizedBox(height: height*0.02,),
        CustomColumnWithTextForm(
          text: 'Return Date',
          customTextFormField: SizedBox(
            width: width*0.6,
            child: const CustomTextFormField(
              border: 10,
              prefix: IconButton(onPressed: null, icon: Icon(Icons.date_range_outlined)),
            ),
          ),
        ),
      ],
    );
  }
}