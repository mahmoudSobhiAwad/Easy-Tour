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
              Text('${cubit.totalAdultNum} adult. ${cubit.totalChildNum} children .${cubit.roomNum} room'),
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
      child: SingleChildScrollView(

        child: Column(
          children:  [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(onPressed: (){
                cubit.showOrClosePickOccupancies();
              }, icon:const Icon(Icons.close)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Number Of Rooms'),
                IncreaseOrDecreaseNumber(
                  changedIndex: cubit.roomNum,
                  changeRoomNum: ({required bool increase}){
                  cubit.changeRoomNum(increase: increase);
                },),
              ],
            ),

            ...List.generate(cubit.roomNum, (buildIndex) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Text('Room ${buildIndex+1}',style: CustomTextStyle.fontBold16,)),
                const SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Adult Numbers'),
                    IncreaseOrDecreaseNumber(
                      changedIndex: cubit.occupanciesList[buildIndex].adultNum,

                      changeOccupancy: ({required bool increase,required int index,required int occIndex }){
                        cubit.changeAdultOrChildOrRoomNum(index:0 ,occupancyIndex: buildIndex,add:increase );
                      },),
                  ],
                ),
                SizedBox(height: height*0.025),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Child Num'),
                    IncreaseOrDecreaseNumber(
                      changedIndex: cubit.occupanciesList[buildIndex].childNum,
                      changeOccupancy: ({required bool increase,required int index,required int occIndex }){
                        cubit.changeAdultOrChildOrRoomNum(index:1 ,occupancyIndex: buildIndex,add:increase );
                      },),
                  ],
                ),
                cubit.occupanciesList[buildIndex].childNum>0?SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...List.generate(cubit.occupanciesList[buildIndex].childNum, (index) => Padding(
                          padding:const EdgeInsets.symmetric(horizontal: 10),
                          child: CustomDropDownMenu(
                            initialValue: cubit.occupanciesList[buildIndex].paxList?[index].age.toString(),
                            onSelected: (String?value){
                            cubit.fillPaxList(index: index, val: value??'0', occupancyIndex: buildIndex);
                          },list: List.generate(15, (index) =>(index+1).toString()),label: 'Age',labelStyle: CustomTextStyle.fontNormal14WithEllipsis,)),)
                    ],
                  ),
                ):const SizedBox(),
              ],
            ),),
          ],
        ),
      ),
    );
  }
}

class IncreaseOrDecreaseNumber extends StatelessWidget {
  const IncreaseOrDecreaseNumber({
    super.key,

    this.changeRoomNum,
    this.changeOccupancy,
    this.roleIndex,
    required this.changedIndex,
    this.occIndex,
  });

  final int? occIndex;
  final int? roleIndex;
  final int changedIndex;
  final void Function({required bool increase})?changeRoomNum;
  final void Function({required bool increase,required int index,required int occIndex})?changeOccupancy;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap:(){
            changeRoomNum!=null?
            changeRoomNum!(increase: true):
            changeOccupancy!(increase:true,index:roleIndex??0,occIndex:occIndex??0);
          },
          child: const CircleAvatar(
            child: Icon(Icons.add,),
          ),
        ),
        const SizedBox(width: 2.5,),
        Text('$changedIndex'),
        const SizedBox(width: 2.5,),
        GestureDetector(
          onTap:(){
            changeRoomNum!=null?
            changeRoomNum!(increase: false):
            changeOccupancy!(increase:false,index:roleIndex??0,occIndex:occIndex??0);
          },
          child: const CircleAvatar(
            child: FaIcon(FontAwesomeIcons.minus,),
          ),
        ),
      ],);
  }
}