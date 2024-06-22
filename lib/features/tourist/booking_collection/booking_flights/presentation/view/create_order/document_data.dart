import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/core/widget/sign_up_edit/custom_drop_down.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/two_beside_form.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/manager/create_order/cubit.dart';
import 'package:prepare_project/features/tourist/profile/presentation/views/widgets/pick_country.dart';
class DocumentData extends StatelessWidget {
  const DocumentData({
    super.key,
    required this.height,
    required this.width,
    required this.cubit,
    required this.index,
  });

  final double height;
  final double width;
  final CreateFlightOrderCubit cubit;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Document Date',style: CustomTextStyle.fontBold14,),
        SizedBox(height: height*0.01,),
        CustomTwoFieldForm(
          firstText: 'Type',
          firstCustomFormField:  CustomDropDownMenu(
            width: width*0.4,
            list:const[
              "VISA",
              "PASSPORT",
              "IDENTITY_CARD",
              "KNOWN_TRAVELER",
              "REDRESS"],
            initialValue:cubit.travelersData[index].docType??"PASSPORT",
            onSelected: (String?value){
              cubit.changeAnyTypeAndFillList(index: index, fieldType: CreateFlightTypes.docType, fieldContent: value??'PASSPORT');
            },),
          secondText: 'Birth Place',
          secondCustomFormField:SizedBox(width: width*0.4,child:  CustomTextFormField(
            controller: TextEditingController(text: cubit.travelersData[index].docBirthPlace),
            onFiledSubmitted: (value){
              cubit.changeAnyTypeAndFillList(index: index, fieldType: CreateFlightTypes.birthPlace, fieldContent: value??"");
            },
          ),),
        ),
        SizedBox(height: height*0.01,),
        CustomTwoFieldForm(
          firstText: 'Pick Country',
          firstCustomFormField: PickCountry(
            width: width*0.4,
            countryFlag:cubit.travelersData[index].nationality?.flagEmoji,
            countryName: cubit.travelersData[index].nationality?.name??"Unknown",
            onSelect: (value)
            {
              cubit.changeNationality(index, value);
            },
          ),
          secondText: 'Issuance Date',
          secondCustomFormField:SizedBox(width: width*0.4,child: CustomTextFormField(
            controller: TextEditingController(text: cubit.travelersData[index].issuanceDate),
            onFiledSubmitted: (value){
              cubit.changeAnyTypeAndFillList(index: index, fieldType: CreateFlightTypes.issuanceDate, fieldContent: value??"");
            },
            suffix:GestureDetector(
                onTap: (){
                  showDatePicker(context: context, initialDate: DateTime(2017), firstDate: DateTime(2015), lastDate: DateTime(DateTime.now().year+7)).then((value) {
                    if(value!=null) {
                      cubit.changeAnyTypeAndFillList(
                          index: index,
                          fieldType: CreateFlightTypes.issuanceDate,
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
