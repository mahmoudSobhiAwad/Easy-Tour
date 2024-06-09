import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/tourist/currency_converter/presentation/manager/currency_converter_cubit.dart';
import 'package:prepare_project/features/tourist/currency_converter/presentation/view/widgets/converted_amount_widget.dart';
class ConversionWidget extends StatelessWidget {
  const ConversionWidget({
    super.key,
    required this.height,
    required this.width,
    required this.cubit,
  });

  final double height;
  final double width;
  final CurrencyConverterCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: commonBorderRadius(),
        border: Border.all(color: secondaryColor,width: 4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Amount',style: CustomTextStyle.font14Light,),
          AmountConverterWidget(
            onChangeInValue: (){
              cubit.getConvertedCurrency();
            },
            controller: cubit.inputAmountController,
            onChanged:(value){
              cubit.getIndexFromCurrencyCode(value, type: 'base');
            },height: height, width: width,list: cubit.nameWithIcon, currencyIcon: cubit.initialCurrency?.based.currencyIcon, currencyCode: cubit.initialCurrency?.based.currencyCode,),
          SizedBox(height: height*0.0125,),
          GestureDetector(
            onTap: (){
              cubit.swapTwoCurrencies();
            },
            child: Center(
              child:  CircleAvatar(
                backgroundColor: forthColor,
                child:Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: cubit.isLoading?const CircularProgressIndicator(color: whiteColor,):const Icon(Icons.swap_vert_outlined,color: Colors.white,),
                ),
              ),
            ),
          ),
          SizedBox(height: height*0.0125,),
          const Text('Converted Amount',style: CustomTextStyle.font14Light,),
          AmountConverterWidget(
            controller: cubit.outputAmountController,
            height: height, width: width,list: cubit.nameWithIcon, currencyIcon: cubit.initialCurrency?.target.currencyIcon, currencyCode: cubit.initialCurrency?.target.currencyCode,enable: false, onChanged: (String value) {
            cubit.getIndexFromCurrencyCode(value, type: 'target');
          },),
          SizedBox(height: height*0.0125,),

        ],
      ),
    );
  }
}