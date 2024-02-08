import 'package:flutter/material.dart';
import 'package:prepare_project/core/widget/sign_up_edit/custom_column_with_text_form.dart';
import 'package:prepare_project/core/widget/sign_up_edit_profile/lang_pref_types.dart';
import 'package:prepare_project/features/sign_up/presentation/manager/sign_up_cubit.dart';
import 'package:prepare_project/features/tourist/profile/presentation/views/widgets/tourist_pref_container.dart';
class LanguageField extends StatelessWidget {
  const LanguageField({super.key,required this.height,required this.cubit,required this.width});
  final double height;
  final double width;
  final SignUpCubit cubit;

  @override
  Widget build(BuildContext context) {
    return CustomColumnWithTextForm(
      text: 'Languages',
      customTextFormField: TouristPreferences(
        onTap: (){
          cubit.changeCustomDrop();
        },
          prefOrLang: PrefOrLang.grid,
          itemHeight: height*0.06,
          widgetHeight: height*0.15,
          titleButton: 'Languages',
          height: height,
          width:width,
          prefs: cubit.languages.toList(),
          removePref: (String?value){
            cubit.removeLanguageFromList(value);
          }),
    );
  }
}
