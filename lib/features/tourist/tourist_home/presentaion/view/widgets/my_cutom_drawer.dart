import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/features/tourist/tourist_home/presentaion/view/widgets/drawer_body.dart';

import '../../../../../../core/utilities/constant_var/constant.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
    required this.height,
    required this.width,
    required this.onClose,
    required this.logOut,
    required this.name,
    required this.profileUrl,
    this.role=Role.tourist,
    required this.touristDrawerList,

  });

  final double height;
  final double width;
  final Role role;
  final void Function()?onClose;
  final Future<void> Function() logOut;
  final String?name;
  final String?profileUrl;
  final List<Icon> touristDrawerList;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            height: height,
            width: width*0.75,
            decoration: const BoxDecoration(
              color:thirdColor,
              borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)),
            ),
            child: CustomDrawerBody(onClose: onClose, height: height,logOut:logOut,name:name,profileUrl:profileUrl,role:role,drawerList: touristDrawerList,),
          ),
        ),
      ),
    );
  }
}


