
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/utilities/go_router/go_router.dart';

class TouristHomeDrawerListTile extends StatelessWidget {
  const TouristHomeDrawerListTile({
    super.key,
    required this.index,
    required this.listTileIcons,
  });
  final int index;
  final List<Icon>listTileIcons;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: [
            (){
          context.push(RouterApp.kUserInfo);
        },
            (){
          context.push(RouterApp.kTouristSettings);
        },
            (){
          context.push(RouterApp.kTouristSettings);
        },
            (){
          context.push(RouterApp.kTouristSettings);
        },
            (){

        },
      ][index],
      contentPadding: EdgeInsets.zero,
      title: Text(['Profile','Settings','Favourite Places','History of trips','Notifications'][index]),
      leading:listTileIcons[index],
      trailing:const Icon(Icons.arrow_forward_ios),
    );
  }
}
