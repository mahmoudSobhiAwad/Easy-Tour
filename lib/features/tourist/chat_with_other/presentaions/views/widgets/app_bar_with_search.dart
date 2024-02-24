import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';

class AppBarWithSearchWidget extends StatelessWidget {
  const AppBarWithSearchWidget({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: const Icon(Icons.arrow_back_ios_new)),
            const SizedBox(width: 10,),
            const Text('Chats',style: CustomTextStyle.privateTourTitle,),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
              height: height*0.06,
              child:const CustomTextFormField(
                filled: true,
                fillColor: thirdColor,
                label: 'Search...',
                borderColor: thirdColor,
                suffix: Icon(Icons.search_outlined,color: entertainmentColor,),
                floatingLabelBehavior: FloatingLabelBehavior.never,)
          ),
        ),
      ],
    );
  }
}