import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/manager/hotel_booking_cubit/hotel_booking_cubit.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/date_picker_destination.dart';

class DateWithPassengerNumbersWithPlace extends StatelessWidget {
  const DateWithPassengerNumbersWithPlace({super.key,required this.height,required this.width,required this.onSearch,required this.cubit});
  final double width;
  final double height;
  final void Function() onSearch;
  final HotelBookingCubit cubit;

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        DatePickerWithDestination(width: width, height: height,cubit: cubit,),
        SizedBox(height: height*0.02,),
        Container(
          width: width*0.75,
          height: height*0.08,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: secondaryColor,width: 2),
          ),
          child:  Row(
            children: [
              const IconButton(icon: Icon(Icons.person), onPressed:null,),
              Text('${cubit.adultNum} adult. ${cubit.childNum} children .${cubit.roomNum} room'),
              IconButton(onPressed: (){
                showBottomSheet(
                    context: context,
                    constraints: BoxConstraints(maxWidth: width,maxHeight: height*0.3),
                    builder:(context){
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(topLeft:Radius.circular(12) ,topRight: Radius.circular(12) ),
                          border: Border.all(color: secondaryColor,width: 2),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:  [
                            ...List.generate(3, (index) => Row(
                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                              children: [
                                Text(['Adult','Children','Rooms'][index]),
                                Row(children: [
                                  GestureDetector(
                                    onTap:(){
                                      cubit.changeAdultOrChildOrRoomNum(index: index, add: true);
                                    },
                                    child: const CircleAvatar(
                                      child: Icon(Icons.add,),
                                    ),
                                  ),
                                  const SizedBox(width: 2.5,),
                                  Text('${[cubit.adultNum,cubit.childNum,cubit.roomNum][index]}'),
                                  const SizedBox(width: 2.5,),
                                  GestureDetector(
                                    onTap:(){
                                      cubit.changeAdultOrChildOrRoomNum(index: index, add: false);
                                    },
                                    child: const CircleAvatar(
                                      child: FaIcon(FontAwesomeIcons.minus,),
                                    ),
                                  ),
                                ],)
                              ],
                            ),),
                            CustomLoginButton(altWidth: width*0.3,label: 'Save',borderRadius: 12,)
                          ],
                        ),
                      );
                    });
              }, icon:const Icon(Icons.add_circle)),

            ],
          ),
        ),
      ],
    );
  }
}