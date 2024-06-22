import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/profile/presentation/views/widgets/pic_profile_widget.dart';
class IntroInFlightBooking extends StatelessWidget {
  const IntroInFlightBooking({
    super.key,
    required this.height,
    required this.name,
    required this.profileUrl
  });

  final double height;
  final String name;
  final String profileUrl;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: ticketBasicColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                ProfilePicWidget(imageUrl: profileUrl, height: height*0.07),
                const SizedBox(width: 5,),
                Text('Good Morning,$name',style: CustomTextStyle.fontNormal14WithEllipsis.copyWith(color: Colors.white),),
              ],
            ),
            SizedBox(height: height*.02,),
            Text('So where is your holiday destination ?',style: CustomTextStyle.fontBold30.copyWith(color: Colors.white),)
          ],
        ),
      ),);
  }
}