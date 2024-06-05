import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/models/payment_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/manager/payment_personal_data_cubit/payment_personal_data_cubit.dart';
class BookedRoomItem extends StatelessWidget {
  const BookedRoomItem({super.key,required this.height,required this.width,required this.roomIndex,required this.cubit});
  final double width;
  final double height;
  final int roomIndex;
  final PaymentPersonalDataCubit cubit;
  @override
  Widget build(BuildContext context) {
    PaxPayModel paxPayModel=cubit.payPaxList[roomIndex];
    return Container(
      padding:const EdgeInsets.all(7),
      decoration: BoxDecoration(
        border: Border.all(color: secondaryColor,width: 2),
        borderRadius: commonBorderRadius(),
      ),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${paxPayModel.roomName}',style: CustomTextStyle.privateTourTitle,),
          const SizedBox(height: 10,),
          Row(
            children: [
              const Icon(Icons.circle,),
              Text('Cancel Price : ${paxPayModel.cancelPrice}\$'),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              const Icon(Icons.timer,),
              Text('deadLine : ${paxPayModel.deadTime} '),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              const Icon(Icons.check,color: whatsAppColor,),
              Text('${paxPayModel.boardName}'),
            ],
          ),
          const SizedBox(height: 10,),
          SizedBox(
              width: width*0.8,
              child: CustomTextFormField(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                initialValue: cubit.payPaxList[roomIndex].onePaxModel?.name,
                label: 'Full Guest Name',onChanged: (String?value){
                cubit.onChangeText(totalIndex: roomIndex,name: value);
              },)),

          const SizedBox(height: 10,),
        ],
      ),
    );
  }
}