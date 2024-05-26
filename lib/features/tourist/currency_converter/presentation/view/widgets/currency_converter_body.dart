import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/core/widget/sign_up_edit/custom_column_with_text_form.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_app_bar_trip_generated.dart';
import 'package:prepare_project/features/tourist/currency_converter/presentation/manager/currency_converter_cubit.dart';
import 'package:prepare_project/features/tourist/currency_converter/presentation/view/widgets/conversion_widget.dart';
import 'package:prepare_project/features/tourist/nearby_places/presentation/views/widgets/one_category_search.dart';
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