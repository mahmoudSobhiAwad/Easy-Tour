import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
class DateWithFlightRoute extends StatelessWidget {
  const DateWithFlightRoute({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Mon 22 2024',style: CustomTextStyle.fontBold16,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('NYC',style: CustomTextStyle.fontBold16,),
            SizedBox(
              width: width*0.15,
              child: Divider(
                thickness: 3,
                height: height*0.01,
                color: entertainmentColor,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child:ColoredBox(color: ticketBasicColor,child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text('Direct',style: CustomTextStyle.fontNormal14WithEllipsis.copyWith(color: Colors.white),),
              ),),
            ),
            SizedBox(
              width: width*0.15,
              child: Divider(
                thickness: 3,
                height: height*0.01,
                color: entertainmentColor,
              ),
            ),
            const Text('CAI',style: CustomTextStyle.fontBold16,),
          ],
        )
      ],
    );
  }
}