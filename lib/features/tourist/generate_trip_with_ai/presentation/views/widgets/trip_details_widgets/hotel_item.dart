import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/tourist/nearby_places/data/models/nearby_places_model.dart';
class HotelItemInGeneratedTrip extends StatelessWidget {
  const HotelItemInGeneratedTrip({super.key,required this.height,required this.width,required this.model});
  final double height;
  final double width;
  final NearbyPlacesModel model;
  @override
  Widget build(BuildContext context) {
    const String imageUrl='https://www.holderhotelfurniture.com/wp-content/uploads/2020/10/hotel-furniture12-10-1024x684.jpg';
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                  child: Image.network(imageUrl,width: width*0.58,fit: BoxFit.fill,height: height*0.15,)),
              SizedBox(
                  height: height*0.04,
                  child: Text(model.displayName??"",style: CustomTextStyle.fontBold16,overflow: TextOverflow.ellipsis,)),
               Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.location_on_rounded,color: basicColor,),
                  SizedBox(
                      width: width*0.5,
                      child: Text(model.address??"",style: CustomTextStyle.fontNormal14WithEllipsis,)),
                ],
              ),
              const Divider(height: 3,color: thirdColor,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: width*0.4,
                      child: Text(model.priceLevel??"Medium",overflow: TextOverflow.ellipsis,)),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: thirdColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.star,color: Colors.orangeAccent,),
                        Text('${model.rating??""}',style: CustomTextStyle.fontNormal14WithEllipsis,),
                      ],
                    ),
                  )
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