import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
import 'package:prepare_project/features/tour_guide/profile/presentation/manager/contact_info/contact_info_cubit.dart';
import 'package:prepare_project/features/tour_guide/profile/presentation/view/widgets/contact_info_item.dart';

class ContactInfoModelBottomSheetBody extends StatelessWidget {
  const ContactInfoModelBottomSheetBody({
    super.key,
    required this.cubit,
    required this.height,
    required this.width,
  });

  final ContactInfoCubit cubit;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
              onPressed: (){
                cubit.changeBottomSheet();
              },
              icon: const Icon(Icons.close,color: basicColor,)),
        ),
        const SizedBox(height: 15,),
        GestureDetector(
          onTap: (){
            cubit.changeEnableListDrop();
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            height:height*0.07,
            width: width*0.4,
            decoration: BoxDecoration(color: thirdColor,borderRadius: BorderRadius.circular(20),border: Border.all(color: secondaryColor)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(cubit.initialSocialLink),
                IconButton(onPressed: (){
                  cubit.changeEnableListDrop();
                }, icon:const Icon(Icons.keyboard_arrow_down_outlined))
              ],
            ),
          ),
        ),
        const SizedBox(height:20),
        ContactItem(name: cubit.initialSocialLink, cubit: cubit,controller: cubit.addTextEditing,),
        Align(
          alignment: Alignment.center,
          child: CustomLoginButton(label: 'Add',onTap: (){
            cubit.addToSocialLinks(name:cubit.initialSocialLink , link: cubit.addTextEditing.text);
          },),
        ),

      ],
    );
  }
}
