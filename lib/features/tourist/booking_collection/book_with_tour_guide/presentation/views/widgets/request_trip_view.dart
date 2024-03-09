import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/constant_var/constant.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/core/widget/sign_up_edit/custom_column_with_text_form.dart';
import 'package:prepare_project/core/widget/sign_up_edit/phone_field.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_app_bar_trip_generated.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/two_beside_form.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/views/widgets/plan_to_stay.dart';
import 'package:prepare_project/features/tourist/profile/presentation/views/widgets/pick_country.dart';

import '../../../../../../../core/widget/sign_up_edit/custom_drop_down.dart';
class RequestTripView extends StatelessWidget {
  const RequestTripView({super.key});

  @override
  Widget build(BuildContext context) {
    final double height=BasicDimension.screenHeight(context);
    final double width=BasicDimension.screenWidth(context);
    return  Scaffold(
      body: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: width*0.04,vertical: height*0.02),
            children: [
              CustomGeneratedAiTripAppBar(height: height, width: width,appBarTitle: 'Book Private Trip To Egypt in 10 Days',appBarWidth: width*0.7,),
          SizedBox(height: height*0.05,),
          CustomTwoFieldForm(
            firstText: 'User Name',
            firstCustomFormField: SizedBox(
                width: width*0.45,
                child: const CustomTextFormField(fillColor: thirdColor,filled: true,maxLines: 1,)),
            secondText: 'Start Trip Date',
            secondCustomFormField:  SizedBox(
                width: width*0.45,
                child: const CustomTextFormField(fillColor: thirdColor,filled: true,maxLines: 1,suffix: Icon(Icons.calendar_month_rounded),)),
          ),
          const SizedBox(height: 20,),
          const CustomColumnWithTextForm(text: 'Email',customTextFormField: CustomTextFormField(fillColor: thirdColor,filled: true,maxLines: 1,),),
          const SizedBox(height: 20,),
          SizedBox(
            height: height*0.12,
            child: CustomTwoFieldForm(
              firstText: 'Country(optional)',
              secondCustomFormField: PhoneFormField(width: width,),
              secondText: 'Phone Num(optional)',
              firstCustomFormField:  PickCountry(onSelect: (Country value){
              }, width: width*0.43),
            ),
          ),
          const SizedBox(height: 20,),
          TypeOfStay(height: height, width: width, plan: const {},),
          const SizedBox(height: 20,),
          CustomTwoFieldForm(
            firstText: 'Travelers',
            firstCustomFormField: SizedBox(
              width: width*0.45,
              child: const CustomTextFormField(
                maxLines: 1,
                align: TextAlign.center,
                fillColor: thirdColor,
                filled: true,
                prefix: Padding(
                  padding: EdgeInsets.only(left: 5.0),
                  child: CircleAvatar(radius: 20,backgroundColor: basicColor,child: Center(child: FaIcon(FontAwesomeIcons.minus,color: Colors.white,)),),
                ),
                suffix: Padding(
                  padding: EdgeInsets.only(right: 5.0),
                  child: CircleAvatar(radius: 20,backgroundColor: basicColor,child: Center(child: Icon(Icons.add,color: Colors.white,)),),
                ),
              ),
            ),
            secondText: 'Age Range(optional)',
            secondCustomFormField: CustomDropDownMenu(
              fillColor: thirdColor,
              width: width*0.45,
              list: languages,
              enableSearch: true,
            ),
          ),
          const SizedBox(height: 20,),
          CustomTwoFieldForm(
            firstText: 'Total Price',
            firstCustomFormField: CircleAvatar(radius: width*0.1,backgroundColor: thirdColor,child:const Center(child: Text('100\$'),),),
            secondCustomFormField: SizedBox(
                width: width*0.65,
                height: height*0.12,
                child: const CustomTextFormField(align: TextAlign.start,label: 'Additional Request...',filled: true,fillColor: thirdColor,expand: true,floatingLabelBehavior: FloatingLabelBehavior.never,)
            )
          ),
              const SizedBox(height: 20,),
              Center(child: CustomLoginButton(label: 'Send Request',altWidth: width*0.6,)),
          ],)),
    );
  }
}
