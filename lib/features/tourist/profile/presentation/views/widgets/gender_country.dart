import 'package:flutter/material.dart';
import 'package:prepare_project/features/tourist/profile/presentation/manager/edit_profile/edit_profile_cubit.dart';
import 'package:prepare_project/features/tourist/profile/presentation/views/widgets/pick_country.dart';
import '../../../../../../core/utilities/constant_var/constant.dart';
import '../../../../../../core/widget/sign_up_edit/custom_drop_down.dart';
import '../../manager/profile_cubit.dart';

class GenderAndCountry extends StatelessWidget {
  const GenderAndCountry({
    super.key,
    required this.height,
    required this.width,
    required this.cubit,
  });

  final double height;
  final double width;
  final EditProfileCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height*0.11,
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomDropDownMenu(
            width: width*0.4,
            list: genders,
            initialValue:cubit.gender,
            onSelected: (String?value){
            cubit.editGender(value);
          },),//done
          PickCountry(
            width: width*0.45,
            countryName: cubit.country,
            countryFlag: cubit.flag,
            onSelect: (value)
          {
            cubit.editCountry(value);
          },

          ),
        ],
      ),
    );
  }
}