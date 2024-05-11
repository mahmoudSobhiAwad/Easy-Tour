import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_app_bar_trip_generated.dart';
import 'package:prepare_project/features/tourist/profile/presentation/views/widgets/pic_profile_widget.dart';
import 'package:prepare_project/features/tourist/settings/presentaion/views/widgets/custom_switch.dart';
import 'package:prepare_project/features/tourist/trip_history/presentation/view/widgets/categories_trip_history.dart';
import 'package:prepare_project/features/tourist/trip_history/presentation/view/widgets/trip_history_body.dart';
class TripHistoryView extends StatelessWidget {
  const TripHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = BasicDimension.screenWidth(context);
    final double height = BasicDimension.screenHeight(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: CustomGeneratedAiTripAppBar(
                height: height, width: width, appBarTitle: 'Trip History',),
            ),
            ListTile(
              leading: ProfilePicWidget(imageUrl: '', height: height * 0.07,),
              title: const Text('Good Morning,john',),
              subtitle: const Text('5 May 2024'),
              trailing: CustomSwitch(
                  active: false, height: height, width: width),
            ),
            const SizedBox(height: 15,),
            CategoryOfTripHistoryTypes(height: height),
            // EmptyHistory(width: width, height: height),
            TripHistoryBody(height: height, width: width),
          ],
        ),
      ),
    );
  }
}






