import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/historical_places/presentation/view/widgets/fav_widget_icon.dart';
import 'package:prepare_project/features/tourist/historical_places/presentation/view/widgets/ticket_price_with_show_map.dart';

class DetailsOfPlaceWithText extends StatelessWidget {
  const DetailsOfPlaceWithText({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: height*0.48,
      child: Container(
        padding:const EdgeInsets.all(16),
        height: height*0.52,
        width: width,
        decoration: const BoxDecoration(
          color: thirdColor,
          borderRadius: BorderRadius.only(topRight:Radius.circular(25) ,topLeft:Radius.circular(25)),

        ),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Giza Pyramids',style: CustomTextStyle.fontGrover22,),
                FavouritePlaceIcon(width: width),
              ],
            ),
            const SizedBox(height: 20,),
            SizedBox(
              height: height*0.33,
              width: width,
              child: const Text('The Egyptian pyramids are ancient masonry structures located in Egypt. Sources cite at least 118 identified "Egyptian" pyramids. Approximately 80 pyramids were built within the Kingdom of Kush, now located in the modern country of Sudan. Of those located in modern Egypt, most were built as tombs for the country\'s pharaohs and their consorts during the Old and Middle, The Egyptian pyramids are ancient masonry structures located in  Egypt. Sources cite at least 118 identified "Egyptian"pyramids. Approximately 80 pyramids were built within Kingdom of Kush, now ',
                style: CustomTextStyle.fontNormal14WithEllipsis, overflow: TextOverflow.ellipsis,maxLines: 15,
              ),),
            const Expanded(child: SizedBox(height: 10,)),
            TicketWithShowInMap(height: height, width: width),
          ],
        ) ,
      ),
    );
  }
}