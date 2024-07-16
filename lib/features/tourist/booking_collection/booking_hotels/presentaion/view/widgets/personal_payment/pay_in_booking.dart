import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/core/widget/sign_up_edit/custom_column_with_text_form.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_app_bar_trip_generated.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/two_beside_form.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/manager/payment_personal_data_cubit/payment_personal_data_cubit.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/personal_payment/card_month_formatter.dart';
class PayInBookingView extends StatelessWidget {
  const PayInBookingView({super.key,required this.width,required this.height,required this.cubit});
  final double width;
  final double height;
  final PaymentPersonalDataCubit cubit;
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      padding:const EdgeInsets.symmetric(horizontal: 15,).copyWith(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomGeneratedAiTripAppBar(height: height, width: width,appBarTitle: 'Payment',appBarStyle:CustomTextStyle.fontBold30,extraOnBack:(){
            cubit.toggleBetweenPages(0);
          },backDirect: false,),
          SizedBox(height: height*0.05,),
           Text('Pay Safely',style: CustomTextStyle.fontBold21,),
          SizedBox(height: height*0.02,),
          CustomColumnWithTextForm(
            text: 'Name on Card ',
            customTextFormField: CustomTextFormField(
              onChanged: (value){
                cubit.cardName=value;
              },
              label: 'Name',floatingLabelBehavior: FloatingLabelBehavior.never,),
          ),
          SizedBox(height: height*0.02,),
          CustomColumnWithTextForm(
            text: 'Card Number',
            customTextFormField: CustomTextFormField(
              controller: cubit.creditCardNumber,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(19),
                CardNumberInputFormatter(),
              ],
              suffix: Icon(cubit.creditData?.iconData),
              label: 'XXXX   XXXX   XXXX   XXXX',
              onChanged: (value){
                cubit.changeVisaIcon(value);
             },
              type: TextInputType.number,
              floatingLabelBehavior: FloatingLabelBehavior.never,),
          ),
          SizedBox(height: height*0.02,),
          CustomTwoFieldForm(
            firstText: 'Expiry Date',
            firstCustomFormField: SizedBox(
              width: width*0.4,
              child: CustomTextFormField(
                onChanged: (value){
                  cubit.changeDateForm(value);
                },
                type: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                  ExpiryDateInputFormatter(),
                ],
                label: 'MM/YY',
                floatingLabelBehavior: FloatingLabelBehavior.never,),),
            secondText: 'Security Code',
            secondCustomFormField: SizedBox(
              width: width*0.4,
              child: CustomTextFormField(
                onChanged: (value){
                  cubit.onChangeCvv(value);
                },
                type: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3),
                ],
                label: 'CVV',
                floatingLabelBehavior: FloatingLabelBehavior.never,),),
          ),
          SizedBox(height: height*0.05,),
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              border: Border.all(color: thirdColor,width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: null,icon:Icon(Icons.document_scanner_outlined)),
                SizedBox(width: 5,),
                Text('Scan Card',style: CustomTextStyle.fontBold16,),
              ],
            ),
          ),
          SizedBox(height: height*0.1,),
          Center(child: CustomLoginButton(borderRadius: 12,label: 'Pay & Book',color: forthColor,onTap: (){
            cubit.payAndBook();
          },))
        ],
      ),
    );
  }
}