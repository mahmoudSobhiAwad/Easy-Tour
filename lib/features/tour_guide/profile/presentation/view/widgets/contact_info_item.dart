import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/core/widget/tour_guide/get_social_widget.dart';
import 'package:prepare_project/features/tour_guide/profile/presentation/manager/contact_info/contact_info_cubit.dart';

class ContactItem extends StatelessWidget {
  const ContactItem({super.key,required this.name,required this.cubit,this.initialText,required this.controller,});
  final String name;
  final ContactInfoCubit cubit;
  final String?initialText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name),
          const SizedBox(height: 5,),
          CustomTextFormField(
            suffix:IconButton(onPressed: (){cubit.removeFromSocialLinks(name: name);}, icon: const Icon(Icons.delete_rounded,color: closeColor,)),
            controller:controller,
            border: 20,
            prefix: SizedBox(
              width: 60,
              height: 70,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getSocialIcon(name),
                    const VerticalDivider(thickness: 1,color:Color(0xffCDCDCD),indent: 5,endIndent: 5,),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}