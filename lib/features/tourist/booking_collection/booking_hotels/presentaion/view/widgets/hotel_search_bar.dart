import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/two_beside_form.dart';

class SearchForHotelsWithNameOfDest extends StatelessWidget {
  const SearchForHotelsWithNameOfDest({super.key,required this.width,required this.height,this.onChanged,required this.controller,this.searchForHotel});
  final double width;
  final double height;
  final TextEditingController controller;
  final void Function(String?val)?onChanged;
  final void Function()?searchForHotel;
  @override
  Widget build(BuildContext context) {
    return  CustomTwoFieldForm(
      firstCustomFormField: SizedBox(
        width: width*0.65,
        height: height*0.08,
        child: CustomTextFormField(
          label: 'Destination',
          floatingLabelBehavior: FloatingLabelBehavior.never,
          controller: controller,
          onChanged:onChanged,
          border: 10,
          maxLines: 1,
          filled: true,
          prefix: const Icon(Icons.bed_rounded),
        ),
      ),
      secondCustomFormField: Padding(
        padding: EdgeInsets.only(left: width*0.15),
        child: CircleAvatar(
          radius: width*0.06,
          backgroundColor: forthColor,
          child: IconButton(onPressed: searchForHotel, icon: const Icon(Icons.search,color: whiteColor,)),
        ),
      ),
    );
  }
}
