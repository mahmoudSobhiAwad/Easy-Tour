import 'package:flutter/material.dart';
import 'package:prepare_project/core/widget/login_sign_up/address_field.dart';
import 'package:prepare_project/core/widget/login_sign_up/date_field.dart';
import 'package:prepare_project/core/widget/sign_up_edit/describe_field.dart';
import 'package:prepare_project/core/widget/sign_up_edit/name_form_field.dart';
import 'package:prepare_project/core/widget/sign_up_edit/phone_field.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/two_beside_form.dart';
import 'package:prepare_project/features/tour_guide/profile/presentation/manager/edit_personal_info_cubit/profile_info_cubit.dart';
class TextFormInfoData extends StatelessWidget {
  const TextFormInfoData({
    super.key,
    required this.height,
    required this.cubit,
    required this.width,
  });

  final double height;
  final EditProfileInfoGuideCubit cubit;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.all(20).copyWith(bottom: 0),
      child: SizedBox(
        height: height*0.54,
        child: Column(
          children: [
            CustomTwoFieldForm(firstText: 'FirstName',secondText: 'SecondName',firstCustomFormField:NameFormField(controller: cubit.firstNameTextEditingController,) ,secondCustomFormField: NameFormField(controller: cubit.lastNameTextEditingController,),),
            AddressTextForm(controller: cubit.addressTextEditingController,),
            const SizedBox(height: 20,),
            CustomTwoFieldForm(firstText: 'Date Of Birth',secondText: 'Phone Number',firstCustomFormField:DateFormField(controller:cubit.dateTextEditingController,width: width,) ,secondCustomFormField: PhoneFormField(controller: cubit.phoneTextEditingController,width: width,),),
            const SizedBox(height: 20,),
            DescribeYourSelf(controller: cubit.describeTextEditingController,),
          ],
        ),
      ),
    );
  }
}