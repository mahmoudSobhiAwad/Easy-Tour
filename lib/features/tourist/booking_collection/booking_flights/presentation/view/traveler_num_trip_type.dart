
import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/two_beside_form.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/manager/get_ticket/cubit.dart';
class TravelersDateAndTripType extends StatelessWidget {
  const TravelersDateAndTripType({
    super.key,
    required this.width,
    required this.height,
    required this.cubit
  });

  final double width;
  final double height;
  final GetTicketCubit cubit;
  @override
  Widget build(BuildContext context) {
    return CustomTwoFieldForm(
      mainAlignment: MainAxisAlignment.spaceBetween,
      firstCustomFormField:Container(
        width: width*0.6,
        height: height*0.07,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: secondaryColor,width: 2),
        ),
        padding:const EdgeInsets.all(5),
        child: Row(
          children: [
            const Icon(Icons.person),
            Text('${cubit.adultNum} Adult, ${cubit.childNum} Children'),
            IconButton(onPressed:(){
              cubit.enableChangeAdultOrChild();
            },icon:const Icon(Icons.add_circle),),
          ],
        ),
      ),
      firstText:'Travelers' ,
      secondCustomFormField:Container(
        width: width*0.3,
        height: height*0.07,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: secondaryColor,width: 2),
        ),
        child: Row(
          children: [
            SizedBox(
                width:width*0.2,
                child:Text(cubit.pickedCabin,style: CustomTextStyle.fontNormal14WithEllipsis,)),
            GestureDetector(
              onTap: (){
                showMenu(context: context,
                    constraints: BoxConstraints(maxHeight: height*0.1,maxWidth: width*0.3),
                    position: RelativeRect.fromLTRB(width*0.8,height*0.8,15, height*0.15), items: [
                      ...List.generate(cubit.cabinTypes.length, (index) => PopupMenuItem(onTap: (){
                        cubit.changeCabinType(index);
                      },child: Text(cubit.cabinTypes[index])))
                    ]
                );
              },
              child: const RotatedBox(
                  quarterTurns: 1,
                  child: Icon(Icons.arrow_forward_ios)),
            ),
          ],
        ),
      ),
      secondText: 'Type',
    );
  }
}