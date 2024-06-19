import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
class TicketInfo extends StatelessWidget {
  const TicketInfo({super.key,required this.instantTicket,required this.lastTicketDate});
  final bool instantTicket;
  final String lastTicketDate;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('Instant Ticket Required',style: CustomTextStyle.fontBold16),
              instantTicket?const Icon(Icons.check,color: whatsAppColor,):const Icon(Icons.close,color: closeColor,)
            ],
          ),
          Text('Last Ticketing Day : $lastTicketDate',style: CustomTextStyle.fontBold16,)
        ],
      ),
    );
  }
}