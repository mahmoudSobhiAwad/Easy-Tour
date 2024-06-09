import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/two_beside_form.dart';
class IssuanceData extends StatelessWidget {
  const IssuanceData({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Issuance Date',style: CustomTextStyle.fontBold14,),
        CustomTwoFieldForm(
          firstText: 'Issuance Country',
          firstCustomFormField: SizedBox(width: width*0.4,child: const CustomTextFormField(suffix: RotatedBox(
              quarterTurns: 1,
              child: Icon(Icons.arrow_forward_ios)),),),
          secondText: 'Issuance Validity',
          secondCustomFormField:SizedBox(width: width*0.4,child: const CustomTextFormField(suffix: Icon(Icons.date_range_rounded),),),
        ),
        SizedBox(height: height*0.01,),
        CustomTwoFieldForm(
          firstText: 'Number',
          firstCustomFormField: SizedBox(width: width*0.4,child: const CustomTextFormField(),),
          secondText: 'Expiry Date',
          secondCustomFormField:SizedBox(width: width*0.4,child: const CustomTextFormField(suffix: Icon(Icons.date_range_rounded),),),
        ),
      ],
    );
  }
}