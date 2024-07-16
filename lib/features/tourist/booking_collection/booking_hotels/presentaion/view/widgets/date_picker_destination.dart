import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/two_beside_form.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/manager/hotel_result_cubit/hotel_result_cubit.dart';
class DatePickerWithDestination extends StatelessWidget {
  const DatePickerWithDestination({
    super.key,
    required this.width,
    required this.height,
    required this.cubit,
  });

  final double width;
  final double height;
  final HotelResultCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: CustomTwoFieldForm(
        mainAlignment: MainAxisAlignment.center,
        firstCustomFormField: SizedBox(
          width: width*0.45,
          height: height*0.08,
          child: CustomTextFormField(
            initialValue: cubit.destModel.destName,
            enable: false,
            label: 'Destination',
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: 10,
            maxLines: 1,
            filled: true,
            prefix: const Icon(Icons.bed_rounded),
          ),
        ),
        secondCustomFormField: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Container(
            width: width*0.45,
            height: height*0.08,
            decoration: BoxDecoration(
              border: Border.all(color: secondaryColor,width: 2),
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: (){
                  cubit.getRangeDate(context);
                }, icon: const Icon(Icons.date_range_rounded)),
                SizedBox(
                    width: width*0.3,
                    child:Text('${cubit.checkIn}\n${cubit.checkOut}',style: CustomTextStyle.fontNormal14WithEllipsis,)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}