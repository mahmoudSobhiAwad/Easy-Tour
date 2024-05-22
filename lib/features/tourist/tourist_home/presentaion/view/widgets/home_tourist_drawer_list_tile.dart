import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prepare_project/features/tourist/trip_history/presentation/view/widgets/intro_trip_history.dart';

import '../../../../../../core/utilities/go_router/go_router.dart';
import '../../../../trip_history/presentation/view/trip_history_view.dart';

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
            return CustomIntroScreen(imagePath: 'assets/tourist_home/trip_intro.png',mainTitle: 'Manage Your Trips', secondaryTitle: 'You can organize your trips by adding your tasks into separate categories', screenToGo: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const TripHistoryView()));
            },);
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
