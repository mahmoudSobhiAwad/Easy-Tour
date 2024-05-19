import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/tourist_feed/presentation/view/widgets/small_profile_pic.dart';

class PosterInfo extends StatelessWidget {
  const PosterInfo({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SmallProfilePic(width: width),
        const SizedBox(width: 10,),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sara Ahmed'),
            SizedBox(height: 7,),
            Text('5 May 2024'),
          ],
        ),
        const SizedBox(width: 10,),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5),bottomRight: Radius.circular(5),bottomLeft: Radius.circular(5)),
            gradient: LinearGradient(colors: [
              Color(0xffB25FD9),
              Color(0xff324D73),
            ]),
          ),
          child: Text("Tour Guide",style: CustomTextStyle.commonSignThinAlwaysWhite.copyWith(fontSize: 14),),
        ),
      ],
    );
  }
}