import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/models/destinations_model.dart';

class PlaceDestinationInHotelBooking extends StatelessWidget {
  const PlaceDestinationInHotelBooking({
    super.key,
    required this.height,
    required this.width,
    this.lastWidth,
    required this.destinationModel,
  });

  final double height;
  final DestinationModel destinationModel;
  final double width;
  final double? lastWidth;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: commonBorderRadius(),
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
           CachedNetworkImage(
              imageUrl:destinationModel.imageUrl,
              height: height*0.15,width:lastWidth??width*0.45,fit: BoxFit.cover,),
            Padding(
              padding:const EdgeInsets.all(8.0),
              child: SizedBox(
                  width: width*0.4,
                  child: Text(destinationModel.destName,style: CustomTextStyle.font16BoldWhite,maxLines: 2,)),
            )
          ],
        ),
    );
  }
}