import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/utilities/basics.dart';
class SettingDetailsView extends StatelessWidget {
  const SettingDetailsView({super.key,required this.appBarTitle,required this.child});
  final String appBarTitle;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          backgroundColor: thirdColor,
          surfaceTintColor: thirdColor,
          clipBehavior: Clip.none,
          leading:IconButton(onPressed: () {
            context.pop();
          },
              icon: const Icon(Icons.arrow_back_ios_new,color: basicColor,)),
          title:  Text(appBarTitle,style: const TextStyle(color: basicColor,fontWeight: FontWeight.bold,fontSize: 18),),
          centerTitle: true,
        ),
        body:child

    );
  }
}
