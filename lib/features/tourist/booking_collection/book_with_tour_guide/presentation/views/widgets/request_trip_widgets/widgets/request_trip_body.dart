import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/core/widget/sign_up_edit/custom_column_with_text_form.dart';
import 'package:prepare_project/core/widget/sign_up_edit/phone_field.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_app_bar_trip_generated.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/two_beside_form.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/managers/request_trip_cubit/request_trip_cubit.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/views/widgets/plan_to_stay.dart';
import 'package:prepare_project/features/tourist/profile/presentation/views/widgets/pick_country.dart';

class RequestTripToBookBody extends StatelessWidget {
  const RequestTripToBookBody({
    super.key,
    required this.width,
    required this.height,
    required this.cubit,
    this.tripDays,
  });

  final double width;
  final double height;
  final BookTripWithTGCubit cubit;
  final String?tripDays;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: width*0.04,vertical: height*0.02),
          children: [
            CustomGeneratedAiTripAppBar(height: height, width: width,appBarTitle: 'Book Private Trip To Egypt in $tripDays Days',appBarWidth: width*0.7,),
            SizedBox(height: height*0.05,),
            CustomTwoFieldForm(
              firstText: 'User Name',
              firstCustomFormField: SizedBox(
                  width: width*0.45,
                  child: CustomTextFormField(fillColor: thirdColor,filled: true,maxLines: 1,controller: cubit.userNameController,)),
              secondText: 'Start Trip Date',
              secondCustomFormField:  SizedBox(
                  width: width*0.45,
                  child: CustomTextFormField(fillColor: thirdColor,filled: true,maxLines: 1,
                    controller: cubit.startTripDateController,
                    type: TextInputType.datetime,
                    suffix: IconButton(onPressed:(){
                      showDatePicker(context: context,
                          initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(DateTime.now().year+1)).then((value) {
                            cubit.changePickedDate(value);
                      });
                    },icon:const Icon(Icons.calendar_month_rounded)),)),
            ),
            const SizedBox(height: 20,),
            CustomColumnWithTextForm(text: 'Email',customTextFormField: CustomTextFormField(fillColor: thirdColor,filled: true,maxLines: 1,controller: cubit.emailController,),),
            const SizedBox(height: 20,),
            SizedBox(
              height: height*0.12,
              child: CustomTwoFieldForm(
                firstText: 'Country(optional)',
                secondCustomFormField: PhoneFormField(width: width,controller: cubit.phoneController,),
                secondText: 'Phone Num(optional)',
                firstCustomFormField:  PickCountry(onSelect: (Country value){
                  cubit.changeCountry(value);
                }, width: width*0.43,countryFlag: cubit.pickedCountry?.flagEmoji,countryName: cubit.pickedCountry?.name,),
              ),
            ),
            const SizedBox(height: 20,),
            cubit.tripTicket==null?const SizedBox():TypeOfStay(height: height, width: width,
              pickedIndex: cubit.indexTripType,
              plan:cubit.tripTicket,onTap: (index){
              cubit.changePickedTripType(index);
            },),
            const SizedBox(height: 20,),
            CustomTwoFieldForm(
              firstText: 'Travelers',
              firstCustomFormField: SizedBox(
                width: width*0.45,
                child: CustomTextFormField(
                  controller: cubit.travelerNumberController,
                  maxLines: 1,
                  align: TextAlign.center,
                  fillColor: thirdColor,
                  filled: true,
                  prefix:GestureDetector(
                    onTap: (){
                      cubit.minusTravelerNumber();
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: CircleAvatar(radius: 20,backgroundColor: basicColor,child: Center(child: FaIcon(FontAwesomeIcons.minus,color: Colors.white,)),),
                    ),
                  ),
                  suffix: GestureDetector(
                    onTap: (){
                      cubit.increaseTravelerNumber();
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(right: 5.0),
                      child: CircleAvatar(radius: 20,backgroundColor: basicColor,child: Center(child: Icon(Icons.add,color: Colors.white,)),),
                    ),
                  ),
                ),
              ),
              secondText: 'Age(optional)',
              secondCustomFormField: SizedBox(
                  width: width*0.4,
                  child: CustomTextFormField(fillColor: thirdColor,filled: true,maxLines: 1,controller: cubit.ageNumberController,type: const TextInputType.numberWithOptions(signed: false,decimal: false),))
            ),
            const SizedBox(height: 20,),
            CustomTwoFieldForm(
                firstText: 'Total Price',
                firstCustomFormField: CircleAvatar(radius: width*0.1,backgroundColor: thirdColor,child:Center(child: Text('${cubit.totalPrice}\$',style: CustomTextStyle.commonSignThinDark.copyWith(color: basicColor),),),),
                secondCustomFormField: SizedBox(
                    width: width*0.65,
                    height: height*0.12,
                    child: CustomTextFormField(align: TextAlign.start,label: 'Additional Request...',filled: true,fillColor: thirdColor,expand: true,floatingLabelBehavior: FloatingLabelBehavior.never,controller: cubit.commentController,)
                )
            ),
            const SizedBox(height: 20,),
            Center(child: CustomLoginButton(
              isLoading: cubit.isLoadingRequest,
              onTap: (){
              cubit.sendRequestToBookWithTG();
            },label: 'Send Request',altWidth: width*0.6,)),
          ],));
  }
}