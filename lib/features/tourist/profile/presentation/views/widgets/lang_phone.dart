import 'package:flutter/material.dart';
import 'package:prepare_project/features/tourist/profile/presentation/manager/edit_profile/edit_profile_cubit.dart';
import '../../../../../../core/utilities/constant_var/constant.dart';
import '../../../../../../core/widget/sign_up_edit/phone_field.dart';
import '../../../../../../core/widget/sign_up_edit/custom_drop_down.dart';

class LanguageAndPhone extends StatelessWidget {
  const LanguageAndPhone({super.key,this.cubit,required this.width,this.height});
  final double?height;
  final double width;
  final EditProfileCubit? cubit;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height!*0.08,
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomDropDownMenu(
            width: width*0.4,
            list: languages,
            initialValue: cubit?.language??"English",
            enableSearch: true,
            onSelected:(String?value){
              cubit?.editLang(value);
            },),
          PhoneFormField(controller: cubit?.phoneController,initialValue: cubit?.countryCode,width: width,),
        ],
      ),
    );
  }
}