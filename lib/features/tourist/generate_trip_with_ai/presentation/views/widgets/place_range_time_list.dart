import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/sign_up_edit/custom_drop_down.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/data_ui.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/model/destination_with_number_model.dart';
class PlaceWithRangeTimeList extends StatelessWidget {
  const PlaceWithRangeTimeList({
    super.key,
    required this.height,
    required this.destinationList,
    required this.width,
    required this.onSelect,
    required this.pickDate,
    required this.removeAt,
  });

  final double height;
  final List<DestinationPlaceDayModel> destinationList;
  final double width;
  final void Function(String? value, int index) onSelect;
  final void Function(int index) pickDate;
  final void Function(int index) removeAt;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height*0.07*destinationList.length+(destinationList.length>1?8:0),
      child: ListView.separated(
        clipBehavior: Clip.antiAlias,
        padding: EdgeInsets.zero,
        itemCount: destinationList.length,
        itemBuilder:(context,index){
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomDropDownMenu(
                width: width*0.35,
                fontSize: 12,
                fillColor: forthColor,
                color: Colors.white,
                list: placesForGeneratedTrip,
                label: 'Pick Place',
                enableSearch: true,
                labelStyle: CustomTextStyle.font14Light.copyWith(color: Colors.white),
                onSelected:(String?value){
                  onSelect(value,index);
                },
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                height: height*0.07,
                width: width*0.48,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: commonBorderRadius(),
                  boxShadow: [buildBoxShadow()],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    destinationList[index].numOfDay==null? const Text('Pick Range Of Date',style: CustomTextStyle.font12WithEllipsis):Text('From: ${destinationList[index].startDate}\nTo : ${destinationList[index].lastDate}',style: CustomTextStyle.font12WithEllipsis,),
                    IconButton(onPressed:(){
                      pickDate(index);
                    },icon:const Icon(Icons.calendar_month_rounded,)),
                  ],
                ),
              ),
              GestureDetector(
                  onTap:(){removeAt(index);},
                  child: const Icon(Icons.delete,color: closeColor,)),
            ],
          );
        },
        separatorBuilder:(context,index){
          return const SizedBox(height: 8,);
        } ,
      ),
    );
  }
}