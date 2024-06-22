import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/core/widget/sign_up_edit/custom_drop_down.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/two_beside_form.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/manager/create_order/cubit.dart';
class TravelerData extends StatelessWidget {
  const TravelerData({
    super.key,
    required this.width,
    required this.height,
    required this.cubit,
    required this.index
  });

  final double width;
  final double height;
  final CreateFlightOrderCubit cubit;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTwoFieldForm(
          firstText: 'First Name',
          firstCustomFormField: SizedBox(width: width*0.4,child:CustomTextFormField(
            controller: TextEditingController(text: cubit.travelersData[index].fName),
            onFiledSubmitted: (value){
              cubit.changeAnyTypeAndFillList(index: index, fieldType: CreateFlightTypes.fName, fieldContent: value??"");
            },
          ),),
          secondText: 'Last Name',
          secondCustomFormField:SizedBox(width: width*0.4,child: CustomTextFormField(
            controller: TextEditingController(text: cubit.travelersData[index].lName),
            onFiledSubmitted: (value){
              cubit.changeAnyTypeAndFillList(index: index, fieldType: CreateFlightTypes.lName, fieldContent: value??"");
            },
          ),),
        ),
        SizedBox(height: height*0.01,),
        SizedBox(
          width: width*0.75,
          child:CustomTextFormField(
            controller: TextEditingController(text: cubit.travelersData[index].email),
            onFiledSubmitted: (value){
              cubit.changeAnyTypeAndFillList(index: index, fieldType: CreateFlightTypes.email, fieldContent: value??"");
            },
            label: 'Email',suffix: const Icon(Icons.email),),
        ),
        SizedBox(height: height*0.01,),

        CustomTwoFieldForm(
          firstText: 'Gender',
          firstCustomFormField:CustomDropDownMenu(
            width: width*0.4,
            list: const ['MALE','FEMALE'],
            initialValue:cubit.travelersData[index].gender??"MALE",
            onSelected: (String?value){
              cubit.changeAnyTypeAndFillList(index: index, fieldType: CreateFlightTypes.gender, fieldContent: value??'male');
            },),
          secondText: 'Birth Date',
          secondCustomFormField:SizedBox(width: width*0.4,child: CustomTextFormField(
            controller: TextEditingController(text: cubit.travelersData[index].birthDate),
            onFiledSubmitted: (value){
              cubit.changeAnyTypeAndFillList(index: index, fieldType: CreateFlightTypes.dateBirth, fieldContent: value??"");
            },
            prefix: GestureDetector(
                onTap: (){
                  showDatePicker(context: context, initialDate: DateTime(1998), firstDate: DateTime(1970), lastDate: DateTime(DateTime.now().year-6)).then((value){
                    if(value!=null) {
                      cubit.changeAnyTypeAndFillList(
                            index: index,
                            fieldType: CreateFlightTypes.dateBirth,
                            fieldContent: DateFormat('yyyy-MM-dd').format(value));
                      }
                    });
                },
                child: const Icon(Icons.date_range_rounded)),),),
        ),
        SizedBox(height: height*0.01,),
        SizedBox(
          width: width*0.6,
          child: CustomTextFormField(
            controller: TextEditingController(text: cubit.travelersData[index].phoneNum),
            onFiledSubmitted: (value){
              cubit.changeAnyTypeAndFillList(index: index, fieldType: CreateFlightTypes.phoneNum, fieldContent: value??"");
            },
            label: 'Phone Number',
            prefix: const Icon(Icons.phone),
          ),
        ),
      ],
    );
  }
}