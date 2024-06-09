import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
class AdditionalRequest extends StatelessWidget {
  const AdditionalRequest({
    super.key,
    required this.height,
    required this.comment,
  });

  final double height;
  final String? comment;

  @override
  Widget build(BuildContext context) {
    return comment==null?
    const SizedBox(height: 0,):
    Column(
      children: [
        const Text('Additional Request',style: CustomTextStyle.fontBold16,),
        SizedBox(height: height*0.015,),
        Container(
          height: height*0.15,
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: thirdColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: secondaryColor,width: 3),
          ),
          child:SingleChildScrollView(
              child:  Text(comment??"",style: CustomTextStyle.fontNormal14WithEllipsis,overflow: TextOverflow.visible,)),
        ),
      ],
    );
  }
}