import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/models/get_hotel_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/hotel_result/text_details_for_hotel_item.dart';

class OneHotelItemInBooking extends StatelessWidget {
  const OneHotelItemInBooking({super.key,required this.width,required this.height,required this.model,required this.onTap});
  final double width;
  final double height;
  final HotelsModel model;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: secondaryColor,width: 2),
        borderRadius: commonBorderRadius(),
      ),
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: commonBorderRadius(),
            child:model.imagesList?.first.imagePath!=null?
            CachedNetworkImage(
              height: height*0.3,
              width:width*0.33,
              fit: BoxFit.fill, imageUrl:'http://photos.hotelbeds.com/giata/bigger/${model.imagesList?.first.imagePath}',
            ):
            const Icon(Icons.warning,color: closeColor,),
          ),
          TextDetailsOfOneHotel(width: width, height: height,model: model,onTap: onTap),
        ],
      ),
    );
  }
}