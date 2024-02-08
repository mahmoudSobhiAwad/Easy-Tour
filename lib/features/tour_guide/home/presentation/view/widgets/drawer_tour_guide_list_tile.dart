import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prepare_project/core/utilities/go_router/go_router.dart';

class TourGuideHomeDrawerListTile extends StatelessWidget {
  const TourGuideHomeDrawerListTile({
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
            (){},
            (){context.push(RouterApp.kTourGuideSettings);},
            (){},
      ][index],
      contentPadding: EdgeInsets.zero,
      title: Text(['Profile','Settings','My Trips'][index]),
      leading:listTileIcons[index],
      trailing:const Icon(Icons.arrow_forward_ios),
    );
  }
}