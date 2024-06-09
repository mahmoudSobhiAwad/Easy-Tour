import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/features/tour_guide/private_tour/presentation/manager/edit_create_tour/edit_create_tour_cubit.dart';
import 'package:prepare_project/features/tourist/nearby_places/presentation/views/widgets/pick_category_widget.dart';

class MaxPersonPlanPrice extends StatelessWidget {
  const MaxPersonPlanPrice({
    super.key,
    required this.width,
    required this.maxPerson,
    required this.cubit,
    required this.height,
  });

  final double width;
  final double height;
  final TextEditingController maxPerson;
  final CreateEditPrivateTourCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Select Type Of The Trip',style: CustomTextStyle.fontBold16,),
        SizedBox(
          height:height*0.23,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            separatorBuilder: (context,index){
              return const SizedBox(width: 20,);
            },
            itemCount:cubit.planType.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  GestureDetector(
                    onTap:(){
                      cubit.changePickedCategory(index);
                    },
                    child: PickedCategoryItem(height: height, width: width, picked: cubit.planType[index].picked,typeImage: cubit.planType[index].typeImage,),
                  ),
                  Text(cubit.planType[index].typeName,style: CustomTextStyle.fontBold16,overflow: TextOverflow.ellipsis,),
                  SizedBox(
                    width:width*0.25,
                    child: CustomTextFormField(
                      maxLines: 1,
                      align: TextAlign.center,
                      type: TextInputType.number,
                      controller: cubit.planeController[index],
                      enable: index==cubit.pickedPlane,
                      borderColor: index==cubit.pickedPlane?whatsAppColor:null,
                      label:'....',
                      floatingLabelBehavior:FloatingLabelBehavior.never,
                    ),
                  ),

                ],
              );
            },
          ),
        ),
        const Text('This Price is Per Person',style: CustomTextStyle.font14Light,),
        const SizedBox(height: 15,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              width: width*0.43,
              child: CustomTextFormField(
                maxLines: 1,
                border: 20,
                fillColor: thirdColor,
                filled: true,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                enableOutLine: false,
                type: const TextInputType.numberWithOptions(decimal: true),
                controller: maxPerson,
                suffix:SizedBox(
                    width: width*0.25,
                    child: const Padding(
                    padding: EdgeInsets.only(right: 5.0),
                      child: Align(alignment: Alignment.centerRight,child: Text('Max Number',)),
                    )
                ),
              ),
            ),
            SizedBox(
                width: width*0.45,
                child: Text('(Please Make the Number Reasonable)',style: CustomTextStyle.fontNormal14WithEllipsis.copyWith(color: entertainmentColor,fontSize: 12),)),
          ],
        ),
      ],
    );
  }
}