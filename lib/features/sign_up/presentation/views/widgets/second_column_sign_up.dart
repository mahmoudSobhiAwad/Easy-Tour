import 'package:flutter/material.dart';
import 'package:prepare_project/core/widget/login_sign_up/address_field.dart';
import 'package:prepare_project/core/widget/login_sign_up/date_field.dart';
import 'package:prepare_project/core/widget/sign_up_edit/describe_field.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
import 'package:prepare_project/features/sign_up/presentation/manager/sign_up_cubit.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/lang_field.dart';
import 'package:prepare_project/core/widget/sign_up_edit/name_form_field.dart';
import 'package:prepare_project/core/widget/sign_up_edit/phone_field.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/two_beside_form.dart';
import '../../../../../core/utilities/constant_var/constant.dart';
import '../../../../../core/widget/sign_up_edit_profile/position_of_custom_drop_down.dart';


class SecondColumnOfSignUpTourGuide extends StatelessWidget {
  const SecondColumnOfSignUpTourGuide({
    super.key,
    required this.height,
    required this.cubit,
    required this.width
  });
final double height;
final double width;
final SignUpCubit cubit;
  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        Column(
          children: [
            CustomTwoFieldForm(firstText: 'FirstName',secondText: 'SecondName',firstCustomFormField:NameFormField(controller: cubit.nameTextEditingController,) ,secondCustomFormField: NameFormField(controller: cubit.lastNameTextEditingController,),),
            AddressTextForm(controller: cubit.addressTextEditingController,),
            LanguageField(height:height ,cubit: cubit,width: width,),
            const SizedBox(height: 20,),
            CustomTwoFieldForm(firstText: 'Date Of Birth',secondText: 'Phone Number',firstCustomFormField:DateFormField(controller:cubit.dateTextEditingController,width: width,) ,secondCustomFormField: PhoneFormField(controller: cubit.phoneTextEditingController,width: width,),),
            const SizedBox(height: 20,),
            DescribeYourSelf(controller: cubit.describeEditingController,),
            const SizedBox(height: 20,),
            CustomLoginButton(
              label:'Next',
              onTap: (){
                  cubit.submitDetailsTourGuideForm();
                },
            ),
          ],
        ),
       cubit.enableLangDrop? PositionOfCustomDropDown(
          leftWidth:width*0.01,
          bottomHeight: height*0.31,
           items:languages,
            height: height, width: width*0.8, addPref: (String?value){
          cubit.addLanguageToList(value);
        }):
       const SizedBox(),
      ],
    );
  }
}
