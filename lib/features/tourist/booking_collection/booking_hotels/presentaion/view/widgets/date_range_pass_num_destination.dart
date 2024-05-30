import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/sign_up_edit/custom_drop_down.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/manager/hotel_result_cubit/hotel_result_cubit.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/date_picker_destination.dart';

class DateWithPassengerNumbersWithPlace extends StatelessWidget {
  const DateWithPassengerNumbersWithPlace({super.key,required this.height,required this.width,required this.onSearch,required this.cubit});
  final double width;
  final double height;
  final void Function() onSearch;
  final HotelResultCubit cubit;

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
                cubit.showOrClosePickOccupancies();
              }, icon:const Icon(Icons.add_circle)),

            ],
          ),
        ),
      ],
    );
  }
}

class OccupanciesWidget extends StatelessWidget {
  const OccupanciesWidget({
    super.key,
    required this.cubit,
    required this.width,
    required this.height,
  });

  final HotelResultCubit cubit;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: height*0.3,
        maxHeight: height*0.35,
      ),
      decoration: BoxDecoration(
        color: thirdColor,
        borderRadius: const BorderRadius.only(topLeft:Radius.circular(12) ,topRight: Radius.circular(12) ),
        border: Border.all(color: secondaryColor,width: 2),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:  [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(onPressed: (){
              cubit.showOrClosePickOccupancies();
            }, icon:const Icon(Icons.close)),
          ),
          ...List.generate(3, (index) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                  ],),
                ],
              ),
              index==1?SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 10),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...List.generate(cubit.childNum, (index) => Padding(
                        padding:const EdgeInsets.symmetric(horizontal: 10),
                        child: CustomDropDownMenu(onSelected: (String?value){
                          cubit.fillPaxList(index, value??'5');
                        },list: List.generate(15, (index) =>(index+1).toString()),label: 'Age',labelStyle: CustomTextStyle.commonFontThin,)),)
                  ],
                ),
              ):const SizedBox(),
            ],
          ),),
        ],
      ),
    );
  }
}