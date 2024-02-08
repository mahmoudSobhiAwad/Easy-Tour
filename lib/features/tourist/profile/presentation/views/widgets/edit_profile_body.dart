import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/constant_var/constant.dart';
import 'package:prepare_project/core/widget/sign_up_edit_profile/lang_pref_types.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
import 'package:prepare_project/features/tourist/profile/presentation/manager/edit_profile/edit_profile_cubit.dart';
import 'package:prepare_project/features/tourist/profile/presentation/views/widgets/gender_country.dart';
import 'package:prepare_project/features/tourist/profile/presentation/views/widgets/lang_phone.dart';
import 'package:prepare_project/features/tourist/profile/presentation/views/widgets/tourist_pref_container.dart';
import 'package:prepare_project/features/tourist/profile/presentation/views/widgets/user_name_status.dart';
import 'package:prepare_project/features/tourist/profile/presentation/views/widgets/user_pic_cover.dart';
import '../../../../../../core/widget/sign_up_edit_profile/position_of_custom_drop_down.dart';
class ProfileEdit extends StatelessWidget {
  const ProfileEdit({super.key, required this.height, required this.width,required this.cubit});
  final double height;
  final double width;
  final EditProfileCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(right: 20,left: 20,bottom:MediaQuery.of(context).viewInsets.bottom+10),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close,color: secondaryColor,)),
                ),
                UserProfilePicAndCover(widgetHeight: height, widgetWidth: width,cubit: cubit,),
                Center(child: UserNameAndStatus(userName: cubit.name, status: cubit.model.status,)),//done
                const SizedBox(height: 10,),
                GenderAndCountry(height: height, width: width, cubit: cubit,),
                LanguageAndPhone(cubit: cubit,height: height,width: width,),
                const SizedBox(height: 10,),
                TouristPreferences(
                  prefOrLang: PrefOrLang.list,
                  titleButton: 'Preferences',
                  widgetHeight: height*0.22,
                  itemHeight: height*0.06,
                  prefs: cubit.preferences.toList(),
                  height: height,
                  width: width,
                  removePref: (String?value){
                    cubit.removeFromPrefs(value);
                  },
                  onTap: (){
                    cubit.changePrefsMenuDrop();
                  },),
                SizedBox(height: height*0.05,),
                Align(
                  alignment: Alignment.center,
                  child: CustomLoginButton(
                    label: 'Update',
                    onTap: ()async{
                      await cubit.updateProfileDate();
                    },
                  ),
                ),
              ],
            ),
            cubit.showPrefDrop? PositionOfCustomDropDown(
              items: prefs,
              bottomHeight: height*0.03,
              leftWidth: width*0.03,
              height: height,
              width: width,
              addPref: (String?value){
                cubit.editListOfPrefs(value);
              },):
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}