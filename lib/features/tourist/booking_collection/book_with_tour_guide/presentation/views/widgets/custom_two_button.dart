import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/two_beside_form.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/views/widgets/one_button_guide_profile_for_tourist.dart';
class CustomTwoButton extends StatelessWidget {
  const CustomTwoButton({
    super.key,
    required this.width,
    required this.height,
    this.firstTap,
    this.secondTap,
  });

  final double width;
  final double height;
  final void Function()?firstTap;
  final void Function()?secondTap;

  @override
  Widget build(BuildContext context) {
    return CustomTwoFieldForm(
      firstCustomFormField: GestureDetector(
        onTap: firstTap,
        child: ButtonInTourProfile(
          width: width,
          height: height,
          color: forthColor,
          text: 'Message',
          icon: Icons.send,
        ),
      ),
      secondCustomFormField: GestureDetector(
        onTap: secondTap,
        child: ButtonInTourProfile(
          width: width,
          height: height,
          color: goldenColor,
          text: 'View All Trips',
          icon: Icons.arrow_forward_outlined,
        ),
      ),
    );
  }
}