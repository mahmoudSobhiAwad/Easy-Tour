import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/two_beside_form.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/manager/create_order/cubit.dart';
class IssuanceData extends StatelessWidget {
  const IssuanceData({
    super.key,
    required this.width,
    required this.height,
    required this.cubit,
    required this.index,
  });

  final double width;
  final double height;
  final CreateFlightOrderCubit cubit;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: height*0.01,),
        CustomTwoFieldForm(
          firstText: 'Number',
          firstCustomFormField: SizedBox(width: width*0.4,child: CustomTextFormField(
            controller: TextEditingController(text: cubit.travelersData[index].docNumber),
            onFiledSubmitted: (value){
              cubit.changeAnyTypeAndFillList(index: index, fieldType: CreateFlightTypes.docNumber, fieldContent: value??"");
            },
          ),),
          secondText: 'Expiry Date',
          secondCustomFormField:SizedBox(width: width*0.4,child: CustomTextFormField(
            controller: TextEditingController(text: cubit.travelersData[index].docExpiryDate),
            onFiledSubmitted: (value){
              cubit.changeAnyTypeAndFillList(index: index, fieldType: CreateFlightTypes.expiryDate, fieldContent: value??"");
            },
            suffix:GestureDetector(
                onTap: (){
                  showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(DateTime.now().year+7)).then((value) {
                    if(value!=null) {
                      cubit.changeAnyTypeAndFillList(
                          index: index,
                          fieldType: CreateFlightTypes.expiryDate,
                          fieldContent: DateFormat('yyyy-MM-dd').format(value));
                    }
                  });
                },
                child: const Icon(Icons.date_range_rounded)),),),
        ),
      ],
    );
  }
}