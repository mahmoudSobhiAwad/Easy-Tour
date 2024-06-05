import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/two_beside_form.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/manager/payment_personal_data_cubit/payment_personal_data_cubit.dart';
class ContactDataInHotelBooking extends StatelessWidget {
  const ContactDataInHotelBooking({super.key,required this.width,required this.height,required this.cubit});
  final double width;
  final double height;
  final PaymentPersonalDataCubit cubit;
  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Contact Data',style: CustomTextStyle.resetPassTitle.copyWith(fontSize: 26),),
        CustomTextFormField(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          controller: cubit.emailController,
          type: TextInputType.emailAddress,
          label: 'Email',suffix: const Icon(Icons.email),border: 10,),
        SizedBox(height: height*0.015,),
        CustomTwoFieldForm(
          firstCustomFormField:SizedBox(
              width: width*0.45,
              child: CustomTextFormField(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  type: TextInputType.phone,
                  controller: cubit.phoneController,
                  label: 'Phone',border: 10)) ,
          secondCustomFormField: SizedBox(
              width: width*0.45,
              child: CustomTextFormField(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  controller: cubit.clientController,
                  label: 'Client Ref',border: 10)),
        ),
        SizedBox(height: height*0.015,),
        CustomTextFormField(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          controller: cubit.remarkController,
          label: 'Remark.....',
          maxLines: 4,
        ),
        SizedBox(height: height*0.015,),
        Center(child: CustomLoginButton(label: 'Continue To Pay ',color: forthColor,altWidth: width*0.5,borderRadius: 12,onTap:(){
          cubit.sendCheckBooking();
        }))
      ],
    );
  }
}