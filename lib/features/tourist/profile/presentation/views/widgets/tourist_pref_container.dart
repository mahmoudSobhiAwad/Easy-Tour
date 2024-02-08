import 'package:flutter/material.dart';
import 'package:prepare_project/core/widget/sign_up_edit_profile/lang_pref_types.dart';
import 'package:prepare_project/features/tourist/profile/presentation/views/widgets/preferences_list_view.dart';

import '../../../../../../core/utilities/basics.dart';
import '../../../../../../core/widget/sign_up_edit_profile/pick_lang_or_pref.dart';

class TouristPreferences extends StatelessWidget {
  const TouristPreferences({super.key,required this.prefOrLang,required this.itemHeight,required this.titleButton,this.widgetHeight,required this.height,required this.width,this.onTap,required this.prefs,required this.removePref});
  final double height;
  final double? widgetHeight;
  final double itemHeight;
  final double width;
  final void Function()?onTap;
  final List prefs;
  final void Function(String?value)removePref;
  final String titleButton;
  final PrefOrLang prefOrLang;
  @override
  Widget build(BuildContext context) {
    Widget buildListOfPrefOrLang(){
      switch(prefOrLang){
        case PrefOrLang.list:
          return PreferencesList(height: height, itemHeight: itemHeight, width: width, prefs: prefs, removePref: removePref);
        case PrefOrLang.grid:
          return GridLanguageList(height: height, itemHeight: itemHeight, width: width, language: prefs, removePref: removePref);
        default:
          return PreferencesList(height: height, itemHeight: itemHeight, width: width, prefs: prefs, removePref: removePref);
      }
    }
    return Container(
      padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
      height:widgetHeight,
      width: width,
      decoration: BoxDecoration(
          border: Border.all(color: secondaryColor,width: 2),
          color: formFillColor,borderRadius: BorderRadius.circular(20)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(child: PickPreference(height: height,
            width: switch(prefOrLang)
            {
              PrefOrLang.list => width*0.3,
              PrefOrLang.grid => width*0.3,
            },
            onTap:onTap,titleOfButton:titleButton ,)),
          buildListOfPrefOrLang(),
        ],
      ),
    );
  }
}