import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/constant_var/constant.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tour_guide/home/presentation/view/widgets/drawer_tour_guide_list_tile.dart';
import 'package:prepare_project/features/tourist/profile/presentation/views/widgets/pic_profile_widget.dart';
import 'package:prepare_project/features/tourist/tourist_home/presentaion/view/widgets/home_tourist_drawer_list_tile.dart';
import '../../../../../../core/widget/custom_alert_widget/alert_container.dart';
import '../../../../../../core/widget/custom_alert_widget/alert_types.dart';
class CustomDrawerBody extends StatelessWidget {
  const CustomDrawerBody({
    super.key,
    required this.onClose,
    required this.height,
    required this.logOut,
    required this.name,
    required this.profileUrl,
    required this.drawerList,
    this.role=Role.tourist,
  });

  final void Function()? onClose;
  final double height;
  final Future<void> Function() logOut;
  final String?name;
  final String?profileUrl;
  final List<Icon>drawerList;
  final Role role;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Align(
              alignment: Alignment.topRight,
              child: IconButton(onPressed: onClose, icon: const Icon(Icons.close,color: basicColor,size: 30,))),
          ProfilePicWidget(imageUrl:profileUrl, height: height*0.15,),
          const SizedBox(height: 10,),
           Text('$name',overflow: TextOverflow.ellipsis,style: CustomTextStyle.commonSignDark,),
          const SizedBox(height: 20,),
          SizedBox(
            height: height*0.55,
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...List.generate(drawerList.length, (index) {
                  return role==Role.tourist?TouristHomeDrawerListTile(index: index,listTileIcons:drawerList): TourGuideHomeDrawerListTile(index: index, listTileIcons: drawerList);
                }),
                const Divider(color: Colors.white,thickness: 3),
                ListTile(
                  onTap: () async{
                    await showDialog(
                        context: context, builder: (context)=> ContainerAlertWidget(
                      types: AlertTypes.optionChoice,
                      onTapYes: () async {
                        await logOut();
                      },
                      onTapNo:()
                      {
                        context.pop();
                      } ,
                      content: 'You are about to Log out\n Are You Sure? ',)
                    );
                  },
                  contentPadding: EdgeInsets.zero,
                  leading: const FaIcon(FontAwesomeIcons.arrowRightFromBracket,color: basicColor,),
                  title: const Text('Sign Out'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}


