import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
class RestaurantItemInGeneratedTrip extends StatelessWidget {
  const RestaurantItemInGeneratedTrip({super.key,required this.width,required this.height});
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    const String imageUrl='https://assets.cairo360.com/app/uploads/2022/09/05/290444880_1484243438675046_5078060897977212537_n-875x323.jpg';
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          width: width*0.6,
          padding: EdgeInsets.symmetric(vertical: height*0.01,horizontal: width*0.0125),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: commonBorderRadius(),
            border: Border.all(color: thirdColor,width: 3),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                  child: Image.network(imageUrl,width: width*0.58,fit: BoxFit.fill,height: height*0.15,)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Qasr ElKbabgi',style: CustomTextStyle.commonSignDark,),
                  Text('Open Now ',style: CustomTextStyle.tripDetailsInTourGuide.copyWith(color: whatsAppColor),),
                ],
              ),
              const Text('Mediterranean, Barbecue',style: CustomTextStyle.commonFontThinLight,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.location_on_rounded,color: basicColor,),
                  Text('Cairo',style: CustomTextStyle.commonFontThin,),
                ],
              ),
              const Divider(height: 3,color: thirdColor,),
              Row(
                children: [
                  ...List.generate(5, (index) {
                    return index<4?const Icon(Icons.star,color: Colors.amber,):const Icon(Icons.star_border_purple500_outlined,color: thirdColor,);
                  }),
                  const Text('(100)')
                ],)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0,right: 12),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(color:thirdColor,width: 2 ),
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.open_in_new,color: basicColor,),
          ),
        )
      ],
    );
  }
}