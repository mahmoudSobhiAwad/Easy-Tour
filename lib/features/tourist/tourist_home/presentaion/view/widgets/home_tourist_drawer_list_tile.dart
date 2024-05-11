import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prepare_project/features/tourist/trip_history/presentation/view/widgets/intro_trip_history.dart';

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
          context.push(RouterApp.kCommonSettings);
        },
            (){
          context.push(RouterApp.kCommonSettings);
        },
            (){
          Navigator.push(context, MaterialPageRoute(builder:(context){
            return const TripHistoryIntroView();
          }));
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
