import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/hotel_result/text_details_for_hotel_item.dart';

class OneHotelItemInBooking extends StatelessWidget {
  const OneHotelItemInBooking({super.key,required this.width,required this.height});
  final double width;
  final double height;
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
            child: Image.network(
              'https://th.bing.com/th/id/R.090489dc0119ca9c56b006c43b966941?rik=OKvZIDlg9Xd8Cg&riu=http%3a%2f%2fwww.cfmedia.vfmleonardo.com%2fimageRepo%2f6%2f0%2f100%2f49%2f12%2fcaisi-exterior-3548-hor-clsc_O.jpg&ehk=XkgpdQTUNd18a3ohmSub9UXUhoGZ3yL3s9QJ902cZL4%3d&risl=&pid=ImgRaw&r=0',
              height: height*0.3,
              width:width*0.33,
              fit: BoxFit.fill,
            ),
          ),
          TextDetailsOfOneHotel(width: width, height: height),
        ],
      ),
    );
  }
}