import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/custom_trip/data/model/custom_trip_model.dart';
class CreatedCustomTripItem extends StatelessWidget {
  const CreatedCustomTripItem({super.key,required this.width,required this.height,required this.customTripModel,this.categoryList});
  final double width;
  final double height;
  final CustomTripModel customTripModel;
  final List<String>?categoryList;
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: secondaryColor,width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network('${customTripModel.tripDetailsList?.first.daysDetailsList?.first.image}',width: width,height: height*0.15,fit: BoxFit.cover,)),
          SizedBox(height: height*0.02,),
          SizedBox(
            height: height*0.05,
            child: ListView.builder(
              itemCount: categoryList?.length??0,
              itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: forthColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding:const EdgeInsets.all(5),
                    child: Center(child: Text(categoryList?[index]??"",style: CustomTextStyle.fontNormal14WithEllipsis.copyWith(color: Colors.white),)),
                  ),
                );
              },
              scrollDirection: Axis.horizontal,
            ),
          ),
          SizedBox(height: height*0.015,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Egypt ${customTripModel.tripDetailsList?.length??0} Days',style: CustomTextStyle.fontBold14,),
              Row(
                children: [
                  Text(customTripModel.startDate??"",style:CustomTextStyle.fontBold14,),
                  const Icon(Icons.arrow_forward),
                  Text(customTripModel.endDate??"",style:CustomTextStyle.fontBold14,),
                ],
              ),
            ],
          ),
          SizedBox(height: height*0.015,),
          Text('${customTripModel.title}',style: CustomTextStyle.fontBold21,maxLines: 2,textAlign: TextAlign.start,),
          SizedBox(height: height*0.015,),
          Text(customTripModel.tripDetailsList?.first.daysDetailsList?[0].activity??"",maxLines: 3,overflow: TextOverflow.ellipsis,style: CustomTextStyle.fontBold14,),
          SizedBox(height: height*0.01,),
        ],
      ),
    );
  }
}
