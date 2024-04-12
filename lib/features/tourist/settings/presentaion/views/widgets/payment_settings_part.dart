import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/settings/presentaion/views/widgets/payment_item.dart';


class PaymentSettingsPart extends StatelessWidget {
  const PaymentSettingsPart({super.key,required this.height,required this.width});
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: height*0.2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Payment Settings',style: CustomTextStyle.commonSignThinDark,),
          const Expanded(child:  SizedBox(height: 10,)),
          SizedBox(
              height: height*0.15,
              width: double.infinity,
              child: ListView.separated(
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
                  return GestureDetector(
                      onTap: [
                            (){},
                            (){},
                            (){},
                      ][index],
                      child: PaymentItem(height: height, width: width, imagePath: ['assets/payment_images/Mastercard.png','assets/payment_images/Stripe.png','assets/payment_images/PayPal.png'][index], title: ['add credit card','pay with Stripe','pay with payPal',][index]));
                },
                separatorBuilder: (context,index)=>SizedBox(
                  width: width*0.1,),
                itemCount: 3,
              )
          ),
        ],

      ),
    );
  }
}