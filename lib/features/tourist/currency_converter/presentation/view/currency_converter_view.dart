import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/function/service_locator.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/core/widget/sign_up_edit/custom_column_with_text_form.dart';
import 'package:prepare_project/core/widget/sign_up_edit/custom_drop_down_button.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_app_bar_trip_generated.dart';
import 'package:prepare_project/features/tourist/currency_converter/data/repos/currency_repo_imp.dart';
import 'package:prepare_project/features/tourist/currency_converter/presentation/manager/currency_converter_cubit.dart';
import 'package:prepare_project/features/tourist/currency_converter/presentation/manager/currency_converter_state.dart';
import 'package:prepare_project/features/tourist/nearby_places/data/repos/nearby_places_repo_imp.dart';
import 'package:prepare_project/features/tourist/nearby_places/presentation/views/widgets/one_category_search.dart';
class CurrencyConverterView extends StatelessWidget {
  const CurrencyConverterView({super.key});
  @override
  Widget build(BuildContext context) {
    final double height=BasicDimension.screenHeight(context);
    final double width=BasicDimension.screenWidth(context);
    return  BlocProvider(
      create: (context)=>CurrencyConverterCubit(currencyRepoImpl: getIt.get<CurrencyRepoImpl>(),nearbyPlacesRepoImpl: getIt.get<NearbyPlacesRepoImpl>())..getCurrencyCodeList(),
      child: BlocConsumer<CurrencyConverterCubit,CurrencyConverterState>(
          builder: (context,state){
            var cubit=BlocProvider.of<CurrencyConverterCubit>(context);
            return Scaffold(
              body: CurrencyConverterBody(height: height, width: width,cubit: cubit,),
            );
            },
          listener: (context,state){}),
    );
  }
}

class CurrencyConverterBody extends StatelessWidget {
  const CurrencyConverterBody({
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
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.zero,
          height: height*0.45,
          width: width,
          decoration: const BoxDecoration(
            color: forthColor,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40),bottomRight: Radius.circular(40))
          ),
        ),
        SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            children:[
              CustomGeneratedAiTripAppBar(height: height, width: width),
              CustomContainerWithStroke(height: height, width: width,borderColor: Colors.white,
                  bgColor: forthColor,
                  containWidget: Transform.rotate(
                      angle: -0.784,
                      child:const Icon(Icons.swap_vert_outlined,color: Colors.white,size: 40,))),
              SizedBox(height: height*0.03,),
              Center(child: Text('Currency Converter',style: CustomTextStyle.privateTourTitle.copyWith(color: Colors.white),)),
              SizedBox(height: height*0.03,),
              ConversionWidget(height: height, width: width, cubit: cubit),
              SizedBox(height: height*0.05,),
              CustomColumnWithTextForm(
                text: '- Look for Banks Or ATMs Around You ',
                customTextFormField: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                       SizedBox(
                           width:width*0.5,
                           child: CustomTextFormField(
                             controller: cubit.radiusController,
                             type: TextInputType.number,
                             filled: true,
                             enableOutLine: false,
                             fillColor: thirdColor,
                             suffix: SizedBox(
                               width: width*0.1,
                               child: const Center(child:Text('meter',style: CustomTextStyle.commonFontThin,)),
                           ),)),
                        SizedBox(width: width*0.1,),
                         ClipRRect(
                            borderRadius:const BorderRadius.only(topRight:Radius.circular(10),topLeft: Radius.circular(10),bottomRight:Radius.circular(10),bottomLeft: Radius.circular(10) ),
                            child: ColoredBox(
                              color: basicColor,child: IconButton(icon:const Icon(Icons.search_rounded,color: Colors.white,),onPressed: (){
                                cubit.getNearbyPlaces();
                            },),))
                      ],
                    ),
                    SizedBox(height: height*0.02,),
                    cubit.placesList.isEmpty?const SizedBox():OneCategorySearchItem(height: height, width: width, listModel: cubit.placesList,),
                  ],
                ),
              ),
            ],
          ),
        )

      ],
    );
  }
}

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
          const Text('Amount',style: CustomTextStyle.commonFontThinLight,),
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
          const Text('Converted Amount',style: CustomTextStyle.commonFontThinLight,),
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

class AmountConverterWidget extends StatelessWidget {
  const AmountConverterWidget({
    super.key,
    required this.height,
    required this.width,
    required this.list,
    this.enable=true,
    required this.currencyIcon,
    required this.currencyCode,
    required this.onChanged,
    required this.controller,
    this.onChangeInValue
  });

  final double height;
  final double width;
  final List<String>list;
  final bool enable;
  final String? currencyIcon;
  final String? currencyCode;
  final void Function(String value) onChanged;
  final TextEditingController controller;
  final void Function()?onChangeInValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(currencyIcon??"",style: const TextStyle(fontSize: 40),),
            Text(currencyCode??"",style:CustomTextStyle.commonSignDark),
            const SizedBox(width: 5,),
            CustomDropDownButton(list: list, onChanged: (value){
              onChanged(value!.substring(6));
            }, maxHeight: height*0.2,iconColor: entertainmentColor,maxWidth: width*0.7,style: const TextStyle(fontSize: 16),),
          ],
        ),
        SizedBox(
            width: width*0.4,
            child:CustomTextFormField(
              onChanged: (String?value){
                if(enable){
                  onChangeInValue!();
                }
              },
              style: CustomTextStyle.commonSignDark,
              controller:controller ,
              enable: enable,
              filled: true,
              enableOutLine: false,
              fillColor: thirdColor,border: 20,type: TextInputType.number,)),
      ],
    );
  }
}
