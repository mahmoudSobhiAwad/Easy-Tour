import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tour_guide/private_tour/data/data_ui.dart';
import 'package:prepare_project/features/tour_guide/requested_trips/data/models/handle_request_model.dart';
import 'package:prepare_project/features/tour_guide/requested_trips/presentaions/view/widgets/request_details/custom_divider_in_request_details.dart';
class RequestedTripInfo extends StatelessWidget {
  const RequestedTripInfo({
    super.key,
    required this.height,
    required this.model,
    required this.width,
  });

  final double height;
  final RequestedTripModel model;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         Text('Requested Trip',style: CustomTextStyle.fontBold16,),
        SizedBox(height: height*0.015,),
        Container(
          padding:const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: thirdColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: secondaryColor,width: 3),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius:BorderRadius.circular(15),
                  child: Image.network(model.image??historicalPlace,errorBuilder: (context,_,s){
                    return const Icon(Icons.warning,color: goldenColor,size: 50,);
                  },height: height*0.12,fit: BoxFit.cover,width: width,)),
              Text(model.title??"",style: CustomTextStyle.fontBold16,),
              Text(model.brief??"",style: CustomTextStyle.fontBold21,overflow:TextOverflow.visible,),
            ],
          ),
        ),
        SizedBox(height: height*0.015,),
        DividerInRequestWidget(width: width),
        SizedBox(height: height*0.015,),
      ],
    );
  }
}