import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/core/widget/sign_up_edit/custom_column_with_text_form.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/two_beside_form.dart';
class DocumentData extends StatelessWidget {
  const DocumentData({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Document Date',style: CustomTextStyle.fontBold14,),
        SizedBox(height: height*0.01,),
        CustomTwoFieldForm(
          firstText: 'Type',
          firstCustomFormField: SizedBox(width: width*0.4,child: const CustomTextFormField(suffix: RotatedBox(
              quarterTurns: 1,
              child: Icon(Icons.arrow_forward_ios)),),),
          secondText: 'Birth Place',
          secondCustomFormField:SizedBox(width: width*0.4,child: const CustomTextFormField(),),
        ),
        SizedBox(height: height*0.01,),
        const CustomColumnWithTextForm(
          text: 'Nationality',
          customTextFormField: CustomTextFormField(
            suffix: RotatedBox(
                quarterTurns: 1,
                child: Icon(Icons.arrow_forward_ios)),
          ),
        ),
      ],
    );
  }
}
