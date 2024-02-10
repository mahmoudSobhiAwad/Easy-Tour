import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/tour_guide/private_tour/data/model/private_tour_model.dart';
import 'package:prepare_project/features/tour_guide/private_tour/presentation/manager/edit_create_tour/edit_create_tour_cubit.dart';
import 'package:prepare_project/features/tour_guide/private_tour/presentation/view/widgets/day_details_item.dart';

class DetailsDayList extends StatelessWidget {
  const DetailsDayList({
    super.key,
    required this.height,
    required this.width,
    required this.cubit,
    required this.tripDays,
  });

  final double height;
  final double width;
  final List<TripDay> tripDays;
  final CreateEditPrivateTourCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      height:height*0.3,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: thirdColor,
        borderRadius:commonBorderRadius(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
                physics:const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 10),
                itemCount:tripDays.length,
                itemBuilder: (context,index){
                  return DayDetailsItem(height: height, index: index,width: width, tripDays: tripDays, cubit: cubit);
                }),
          ),
          Container(
            width: width*0.4,
            decoration: BoxDecoration(borderRadius:BorderRadius.circular(10),border: Border.all(color:secondaryColor)),
            child:  TextButton(
                onPressed:(){
                  cubit.changeShowAddDays();
                   },
                child: const Text("Add a Trip",
                  style: CustomTextStyle.commonProfileDark,)),
          ),
        ],
      ),
    );
  }
}




//     showModalBottomSheet(
//     isScrollControlled: true,
//     context: context, builder: (context){
//   return AddOrEditTripModelBottom(
//     height: height,
//     dayNum: tripDays.length+1,
//     width: width,
//     placesOfDay:cubit.places,
//     onTap: (){
//     cubit.addTripDay(cubit.tripDay.length);
//     Navigator.pop(context);
//   }, addAnotherPlaceInDay: () {
//       cubit.addNewPlaceInNewDay();
//   },
//   );
// });




