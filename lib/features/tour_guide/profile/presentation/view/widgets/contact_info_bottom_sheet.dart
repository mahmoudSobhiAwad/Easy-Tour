import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/widget/sign_up_edit_profile/position_of_custom_drop_down.dart';
import 'package:prepare_project/core/widget/tour_guide/get_social_widget.dart';
import 'package:prepare_project/features/tour_guide/profile/presentation/manager/contact_info/contact_info_cubit.dart';
import 'package:prepare_project/features/tour_guide/profile/presentation/view/widgets/bottom_sheet_body.dart';

class ContactInfoBottomSheet extends StatelessWidget {
  const ContactInfoBottomSheet({super.key, required this.height, required this.width, required this.cubit});
  final double height;
  final double width;
  final ContactInfoCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding:const EdgeInsets.all(20).copyWith(bottom: 0),
          height: height*0.4,
          decoration:const BoxDecoration(
            color: thirdColor,
            borderRadius: BorderRadius.only(topRight:Radius.circular(20) ,topLeft:Radius.circular(20) ),
          ),
          child: ContactInfoModelBottomSheetBody(cubit: cubit, height: height, width: width),
        ),
        cubit.enableLangDrop? PositionOfCustomDropDown(
            leftWidth:width*0.05,
            bottomHeight: height*0.07,
            items:socialLinks,
            height: height, width: width*0.8, addPref: (String?value){
          cubit.changeInitialSocial(value??"");
        }):
        const SizedBox(),
      ],
    );
  }
}