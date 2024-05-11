import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tour_guide/private_tour/data/data_ui.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/model/generated_trip_model.dart';
class BestDestinationItem extends StatelessWidget {
  const BestDestinationItem({super.key,required this.height,required this.width,required this.place});
  final double height;
  final double width;
  final Place place;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color:place.picked?whatsAppColor:thirdColor,width: 3),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                place.image!,height: height*0.2,width: width*0.4,fit: BoxFit.fill,errorBuilder: (context,_,q){
                  return Image.network(defaultImage,height: height*0.2,width: width*0.4,fit: BoxFit.fill,);
              },)),
          SizedBox(
              width: width*0.4,
              child: Text(place.name,style: CustomTextStyle.commonSignDark.copyWith(overflow: TextOverflow.ellipsis),)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const FaIcon(FontAwesomeIcons.ticket,color: entertainmentColor,),
              const SizedBox(width: 10,),
              Text('${place.budget}',style: CustomTextStyle.commonFontThin,),
            ],
          ),
        ],
      ),
    );
  }
}