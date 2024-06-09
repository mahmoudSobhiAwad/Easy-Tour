import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tour_guide/private_tour/data/model/private_tour_model.dart';
import 'package:prepare_project/features/tour_guide/private_tour/presentation/manager/edit_create_tour/edit_create_tour_cubit.dart';
import 'package:prepare_project/features/tour_guide/private_tour/presentation/view/widgets/edit_delete_trip_menu_options.dart';
import 'package:prepare_project/features/tour_guide/private_tour/presentation/view/widgets/model_bottom_create_edit.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/views/widgets/trip_details_in_one_day.dart';
class StepperTripDay extends StatelessWidget {
  const StepperTripDay({super.key,required this.height,this.cubit,required this.width,required this.tripDays,required this.currDay,required this.goToSelectedDay});
  final double height;
  final double width;
  final List<TripDay>?tripDays;
  final int currDay;
  final void Function(int index)goToSelectedDay;
  final CreateEditPrivateTourCubit? cubit;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height*.55,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Trip Days',style: CustomTextStyle.fontBold16,),
          SizedBox(
            width: width,
            height: height*0.08,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ...List.generate(tripDays?.length??0, (index) {
                  return Row(
                    children: [
                      InkWell(
                          onTap:(){
                            goToSelectedDay(index);
                          },
                          child: CircleAvatar(radius: width*0.075,backgroundColor: index==currDay?whatsAppColor:secondaryColor,child: Text('Day${index+1}',style: const TextStyle(color: Colors.white),),)),
                      SizedBox(
                          width:width*0.1,
                          child:index==(tripDays!.length-1)? null:const Divider(thickness: 3,color: secondaryColor,)),
                    ],
                  );
                }
                ),
              ],
            ),
          ),
          SizedBox(
            height: height*0.4,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: tripDays?[currDay].dayPlaces?.length,
                itemBuilder: (context,index) {
                  return Row(
                    children: [
                      OneTripPerDayItem(
                          fullWidth: cubit==null?true:false,height: height, width: width,
                          placeItem:tripDays?[currDay].dayPlaces?[index],
                      ),
                      cubit!=null?
                      EditOrAddTripOptionMenu(
                        editTrip: (){
                          showModalBottomSheet(
                              isScrollControlled: true,
                              context: context, builder: (context){
                            return AddOrEditTripModelBottom(
                              onClose:(){
                                Navigator.pop(context);
                              } ,
                              placesOfDay: cubit?.tripDay[currDay].dayPlaces??[],
                              height: height,
                              width: width,
                              labelButton: 'Edit',
                              dayNum: index+1,
                              enable: false,
                              addAnotherPlaceInDay:(){cubit?.addNewPlaceInExistedDay(currDay);},
                              onTap: (){Navigator.pop(context);},
                              clearDay: (int c) {
                              cubit?.removeSpecificTripFromDay(currDay,c);
                            },
                            );
                          });
                        },
                        removeTrip: (){
                          cubit?.removeSpecificTripFromDay(currDay,index);
                        },) :
                      const SizedBox(width: 0,),
                    ],
                  );
                }
            ),
          )
        ],
      ),
    );
  }
}