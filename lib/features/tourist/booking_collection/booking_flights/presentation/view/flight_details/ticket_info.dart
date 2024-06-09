import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
class TicketInfo extends StatelessWidget {
  const TicketInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Ticket Info',style: CustomTextStyle.fontBold21.copyWith(fontSize: 18)),
          Row(
            children: [
              Text('Instant Ticket Required',style: CustomTextStyle.fontBold14.copyWith(fontSize: 12)),
              const Icon(Icons.close,color: closeColor,),
              const Spacer(),
              Text('Payment Card Required',style: CustomTextStyle.fontBold14.copyWith(fontSize: 12),),
              const Icon(Icons.close,color: closeColor)
            ],
          ),

          const Text('Last Ticketing Day : 28 Jun 2024',style: CustomTextStyle.fontBold14,)
        ],
      ),
    );
  }
}