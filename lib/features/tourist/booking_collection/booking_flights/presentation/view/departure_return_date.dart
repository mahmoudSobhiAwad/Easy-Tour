
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/core/widget/sign_up_edit/custom_column_with_text_form.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/manager/get_ticket/cubit.dart';
import 'package:prepare_project/features/tourist/settings/presentaion/views/widgets/custom_switch.dart';
class DepartureAndReturnDate extends StatelessWidget {
  const DepartureAndReturnDate({
    super.key,
    required this.width,
    required this.height,
    required this.cubit,
  });

  final double width;
  final double height;
  final GetTicketCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomColumnWithTextForm(
              text: 'Departure Date',
              customTextFormField: SizedBox(
                width: width*0.6,
                child:  CustomTextFormField(
                  maxLines: 1,
                  border: 10,
                  controller: cubit.departureController,
                  prefix: IconButton(onPressed: (){
                    showDatePicker(context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(), lastDate: DateTime(DateTime.now().year,DateTime.now().month+1)).then((value) {
                          if(value!=null) {
                            cubit.changeDepartureOrReturnDate(
                                time: DateTime.parse(
                                    DateFormat('yyyy-MM-dd').format(value)),
                                departure: true);
                          }
                          });
                  }, icon:const Icon(Icons.date_range_outlined)),),
              ),),
            Column(
              children: [
                const Text('Return Date',style: CustomTextStyle.fontBold16,),
                const SizedBox(height: 5,),
                GestureDetector(
                    onTap: (){
                      cubit.changeEnablingReturn();
                    },
                    child: CustomSwitch(active: cubit.enableReturn, height: height, width: width)),
              ],
            ),
          ],
        ),
        SizedBox(height: height*0.02,),
        cubit.enableReturn?
        CustomColumnWithTextForm(
          text: 'Return Date',
          customTextFormField: SizedBox(
            width: width*0.6,
            child:  CustomTextFormField(
              controller: cubit.returnController,
              border: 10,
              maxLines: 1,
              prefix: IconButton(onPressed: (){
                if(cubit.departureDate!=null){
                  showDatePicker(context: context,
                      initialDate: DateTime(cubit.departureDate!.year,cubit.departureDate!.month,cubit.departureDate!.day+2),
                      firstDate: cubit.departureDate!,
                      lastDate: DateTime(cubit.departureDate!.year,cubit.departureDate!.month+2,)).then((value) {
                        if(value!=null) {
                          cubit.changeDepartureOrReturnDate(time: DateTime
                              .parse(DateFormat('yyyy-MM-dd').format(value)),
                              departure: false);
                        }
                      });
                }
              }, icon: const Icon(Icons.date_range_outlined)),
            ),
          ),
        ):
        const SizedBox(),
      ],
    );
  }
}