import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/tour_guide/private_tour/data/model/private_tour_model.dart';
import 'package:prepare_project/features/tour_guide/private_tour/presentation/manager/edit_create_tour/edit_create_tour_cubit.dart';
import 'package:prepare_project/features/tour_guide/private_tour/presentation/view/widgets/edit_delete_trip_menu_options.dart';
import 'package:prepare_project/features/tour_guide/private_tour/presentation/view/widgets/model_bottom_create_edit.dart';
class DayDetailsItem extends StatelessWidget {
  const DayDetailsItem({
    super.key,
    required this.height,
    required this.width,
    required this.tripDays,
    required this.cubit,
    required this.index
  });

  final double height;
  final double width;
  final List<TripDay> tripDays;
  final CreateEditPrivateTourCubit cubit;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: SizedBox(
        height: height*0.12,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width:width*0.12,
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius:commonBorderRadius(),
              ),
              child: Center(child: Text(tripDays[index].dayName??"",style: CustomTextStyle.commonProfileDark,)),
            ),
            Container(
              padding:const EdgeInsets.all(5),
              width:width*0.58,
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius:commonBorderRadius(),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: List.generate(
                            tripDays[index].dayPlaces?.length??0,
                                (listIndex){
                          return Text('${ tripDays[index].dayPlaces?[listIndex].placeName},');}
                        )),
                  ),
                  SizedBox(
                    height: height*0.08,
                    child: ListView.builder(
                        itemCount:tripDays[index].dayPlaces?.length??0,
                        itemBuilder: (context,listIndex)
                        {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 3.0),
                            child: Text('\t''- ${tripDays[index].dayPlaces?[listIndex].activity}',style: CustomTextStyle.commonFontThin),
                     );
                 }
                 ),
                  ),
                ],
              ),
            ),
            EditOrAddTripOptionMenu(
                editTrip: (){
                  showModalBottomSheet(
                  isScrollControlled: true,
                  context: context, builder: (context){
                    return AddOrEditTripModelBottom(
                      placesOfDay: cubit.tripDay[index].dayPlaces??[],
                      height: height,
                      width: width,
                      labelButton: 'Edit',
                      dayNum: index+1,
                      enable: false,
                      addAnotherPlaceInDay:(){ cubit.addNewPlaceInExistedDay(index);},
                      onTap: (){Navigator.pop(context);},
                    );
                  });
                  },
                removeTrip: (){
                  cubit.removeTripDay(index);
                },),
          ],
        ),
      ),
    );
  }
}