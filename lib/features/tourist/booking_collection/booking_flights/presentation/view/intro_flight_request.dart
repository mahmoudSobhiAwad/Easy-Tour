import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/profile/presentation/views/widgets/pic_profile_widget.dart';
class IntroInFlightBooking extends StatelessWidget {
  const IntroInFlightBooking({
    super.key,
    required this.height,
  });

  final double height;

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
                ProfilePicWidget(imageUrl: 'https://d2qp0siotla746.cloudfront.net/img/use-cases/profile-picture/template_0.jpg', height: height*0.07),
                const SizedBox(width: 5,),
                Text('Good Morning,sara',style: CustomTextStyle.commonFontThin.copyWith(color: Colors.white),),
              ],
            ),
            SizedBox(height: height*.02,),
            Text('So where is your holiday destination ?',style: CustomTextStyle.resetPassTitle.copyWith(color: Colors.white),)
          ],
        ),
      ),);
  }
}