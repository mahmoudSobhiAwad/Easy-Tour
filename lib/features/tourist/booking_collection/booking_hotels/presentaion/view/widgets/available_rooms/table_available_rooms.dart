import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/models/get_availbitly_room_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/available_rooms/build_table_rows.dart';
class TableDetailsOfAvailableRooms extends StatelessWidget {
  const TableDetailsOfAvailableRooms({
    super.key,
    required this.width,
    required this.model,
    required this.changeBookedRoomsNum,
  });

  final double width;
  final List<GetAvailableRoomsModel> model;
  final void Function({required int index,required bool increase})changeBookedRoomsNum;

  @override
  Widget build(BuildContext context){
    return model.isNotEmpty?
    Table(
      columnWidths: const {
        0:FractionColumnWidth(0.15),
        1:FractionColumnWidth(0.15),
        2:FractionColumnWidth(0.3),
        3:FractionColumnWidth(0.25),
        4:FractionColumnWidth(0.15),
      },
      border: TableBorder.all(
        color: secondaryColor,
        width: 2,
        borderRadius: BorderRadius.circular(7),
      ),
      children: [
        buildTableRow(['Room Type','Price','Properties','Cancel Cost','Room Num']),
        ...List.generate(model.length, (index) => buildTableWithWidget(
          [
            Text(model[index].roomName??"",style: CustomTextStyle.commonFontThin.copyWith(fontSize: 12),maxLines: 5,),
            Text('${model[index].rateOfRoom?[0].net}',style: CustomTextStyle.commonFontThin.copyWith(fontSize: 12),maxLines: 5,),
             Column(
              children: [
                Row(
                  children: [
                    Text('Packaging',style: CustomTextStyle.commonFontThin.copyWith(fontSize: 12),maxLines: 5,),
                    model[index].rateOfRoom![0].packaging?const Icon(Icons.check,color: whatsAppColor,):const Icon(Icons.close,color: closeColor,),
                  ],
                ),
                const SizedBox(height: 5,),
                Row(
                  children: [
                    const Icon(Icons.payment,),
                    Text('${model[index].rateOfRoom?[0].paymentType}',style: CustomTextStyle.commonFontThin.copyWith(fontSize: 12),maxLines: 5,),
                  ],
                ),
                const SizedBox(height: 5,),
                Row(
                  children: [
                    const Icon(Icons.dashboard,),
                    Text('${model[index].rateOfRoom?[0].boardName}',style: CustomTextStyle.commonFontThin.copyWith(fontSize: 12),maxLines: 5,),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.monetization_on_rounded,color: closeColor,),
                    Text(model[index].rateOfRoom?[0].cancelPolicies?[0].amount??"0",style: CustomTextStyle.commonFontThin.copyWith(fontSize: 12),maxLines: 5,),
                  ],
                ),
                const SizedBox(height: 5,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.timer,),
                    SizedBox(
                        width: width*0.13,
                        child: Text(model[index].rateOfRoom?[0].cancelPolicies?[0].deadTime??"",style: CustomTextStyle.commonFontThin.copyWith(fontSize: 12),maxLines: 5,)),
                  ],
                ),
              ],
            ),
             Column(
              children: [
                GestureDetector(
                  onTap: (){
                    changeBookedRoomsNum(index: index,increase: true);
                  },
                  child: const CircleAvatar(
                      child: Icon(Icons.add,)),
                ),
                Text('${model[index].rateOfRoom?[0].bookedNum}'),
                GestureDetector(
                  onTap:() {
                    changeBookedRoomsNum(index: index,increase: false);
                  },
                  child: const CircleAvatar(
                      child: FaIcon(FontAwesomeIcons.minus)),
                ),
              ],
            ),
          ],
        )),
      ],
    ) :
    const Text('Sorry there is No available Room in current Time');
  }
}