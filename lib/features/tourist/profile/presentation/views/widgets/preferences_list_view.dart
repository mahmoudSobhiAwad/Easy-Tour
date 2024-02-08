import 'package:flutter/material.dart';

import '../../../../../../core/widget/sign_up_edit_profile/pref_or_lang_item.dart';

class PreferencesList extends StatelessWidget {
  const PreferencesList({super.key,required this.height,required this.itemHeight,required this.width,required this.prefs,required this.removePref});
  final double height;
  final double itemHeight;
  final double width;
  final List prefs;
  final void Function(String?value)removePref;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:height*0.2 ,
      width: width*0.54,
      child: ListView.separated(
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context,index){
            return  PreferenceItem(itemHeight: itemHeight,text: prefs[index],width: width*0.5,removePref: removePref,textWidth:width*0.4);
          },
          separatorBuilder: (context,index){
            return const SizedBox(height:15,);
          }, itemCount: prefs.length),
    );
  }
}
class GridLanguageList extends StatelessWidget {
  const GridLanguageList({super.key,required this.height,required this.itemHeight,required this.width,required this.language,required this.removePref});
  final double height;
  final double itemHeight;
  final double width;
  final List language;
  final void Function(String?value)removePref;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:height*0.12 ,
      width: width*0.5,
      child: GridView.builder(
        padding: EdgeInsets.zero,
          itemCount:language.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio:2,
          ),
          itemBuilder: (context,index){
          //return Container(height: height*0.05,color: Colors.black,);
            return PreferenceItem(itemHeight: itemHeight, text: language[index], width: width*0.25, removePref: removePref,textWidth: width*0.15,);
          })
    );
  }
}
