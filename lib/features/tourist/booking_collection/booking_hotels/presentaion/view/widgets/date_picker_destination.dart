import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/two_beside_form.dart';
class DatePickerWithDestination extends StatelessWidget {
  const DatePickerWithDestination({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: CustomTwoFieldForm(
        mainAlignment: MainAxisAlignment.center,
        firstCustomFormField: SizedBox(
          width: width*0.35,
          height: height*0.08,
          child:const CustomTextFormField(
            border: 10,
            maxLines: 1,
            filled: true,
            prefix: Icon(Icons.bed_rounded),
            suffix: Icon(Icons.close),
          ),
        ),
        secondCustomFormField: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Container(
            width: width*0.55,
            height: height*0.08,
            decoration: BoxDecoration(
              border: Border.all(color: secondaryColor,width: 2),
              color: whiteColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const IconButton(onPressed: null, icon: Icon(Icons.date_range_rounded)),
                SizedBox(
                    width: width*0.4,
                    child:const Text('5 May 2024 - 7 May 2024',style: CustomTextStyle.commonFontThin,)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}