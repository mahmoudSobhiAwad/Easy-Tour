import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/core/widget/sign_up_edit/custom_column_with_text_form.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_app_bar_trip_generated.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/two_beside_form.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/models/get_availbitly_room_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/models/payment_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/manager/payment_personal_data_cubit/payment_personal_data_cubit.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/manager/payment_personal_data_cubit/payment_personal_data_states.dart';

class PersonalDataPaymentForHotelBookingView extends StatelessWidget {
  const PersonalDataPaymentForHotelBookingView({super.key,required this.needRooms});
  final List<GetAvailableRoomsModel>needRooms;
  @override
  Widget build(BuildContext context) {
    final double width=BasicDimension.screenWidth(context);
    final double height=BasicDimension.screenHeight(context);
    return BlocProvider(
      create: (context)=>PaymentPersonalDataCubit(neededRooms:needRooms)..preparePayList(),
      child: BlocConsumer<PaymentPersonalDataCubit,PaymentPersonalDataStates>(
          builder: (context,state){
            var cubit=BlocProvider.of<PaymentPersonalDataCubit>(context);
            return WillPopScope(
              onWillPop: ()async{
                if(cubit.currentPage==0){
                  return true;
                }
                else{
                  cubit.toggleBetweenPages(0);
                  return false;
                }
              },
              child: SafeArea(
                child: Scaffold(
                  body: [PersonalDataInBookingView(height: height,width: width,cubit: cubit,),PayInBookingView(width: width, height: height)][cubit.currentPage],
                ),
              ),
            );
          },
          listener: (context,state){}),);
  }
}
class BookedRoomItem extends StatelessWidget {
  const BookedRoomItem({super.key,required this.height,required this.width,required this.paxPayModel,required this.changeAdultOrChildNum,required this.roomIndex});
final double width;
final double height;
final PaxPayModel paxPayModel;
final int roomIndex;

final void Function({required int index,required bool increase,required bool adult})changeAdultOrChildNum;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.all(7),
      decoration: BoxDecoration(
        border: Border.all(color: secondaryColor,width: 2),
        borderRadius: commonBorderRadius(),
      ),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${paxPayModel.roomName}',style: CustomTextStyle.privateTourTitle,),
          const SizedBox(height: 10,),
          Row(
            children: [
              const Icon(Icons.circle,),
              Text('Cancel Price : ${paxPayModel.cancelPrice}\$'),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              const Icon(Icons.timer,),
              Text('deadLine : ${paxPayModel.deadTime} '),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              const Icon(Icons.check,color: whatsAppColor,),
              Text('${paxPayModel.boardName}'),
            ],
          ),
          const SizedBox(height: 10,),
          ChangePaxNumHotelBooking(
            changedNum: paxPayModel.adultNum,
            adult: true,
            title: 'Adult Num', roomIndex: roomIndex,changeAdultOrChildNum: ({required bool adult,required  bool increase, required int index}) {
            changeAdultOrChildNum(adult: adult,increase: increase,index: index);
            },),
          Column(
            children: [
              ...List.generate(paxPayModel.adultNum, (index) {
                return  CustomTwoFieldForm(
                  firstCustomFormField: SizedBox(
                      width: width*0.4,
                      child: const CustomTextFormField(label: 'Name',)),
                  secondCustomFormField: SizedBox(
                      width: width*0.4,
                      child: const CustomTextFormField(label: 'SurName',)),
                );
          }),
            ],
          ),

          const SizedBox(height: 10,),
           ChangePaxNumHotelBooking(
             changedNum: paxPayModel.childNum,
             adult: false,
             title: 'Children Num',roomIndex: roomIndex,changeAdultOrChildNum: ({required bool adult,required  bool increase, required int index}) {
             changeAdultOrChildNum(adult: adult,increase: increase,index: index);
           },),
          Column(
            children: [
              ...List.generate(paxPayModel.childNum, (index) {
                return  Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: CustomTwoFieldForm(
                    firstCustomFormField: SizedBox(
                        width: width*0.4,
                        child: const CustomTextFormField(label: 'Name',)),
                    secondCustomFormField: SizedBox(
                        width: width*0.4,
                        child: const CustomTextFormField(label: 'SurName',)),
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}

class ChangePaxNumHotelBooking extends StatelessWidget {
  const ChangePaxNumHotelBooking({
    super.key,
    required this.title,
    required this.changeAdultOrChildNum,
    required this.roomIndex,
    required this.adult,
    required this.changedNum,
  });
  final String title;
  final int roomIndex;
  final bool adult;
  final int changedNum;
  final void Function({required int index,required bool increase,required bool adult})changeAdultOrChildNum; 

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
         Row(
          children: [
            GestureDetector(
              onTap: (){
                changeAdultOrChildNum(index: roomIndex,increase: true,adult:adult);
              },
              child: const CircleAvatar(
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Icon(Icons.add),
                  )),
            ),
            const SizedBox(width: 3,),
            Text('$changedNum'),
            const SizedBox(width: 3,),
            GestureDetector(
              onTap: (){
                changeAdultOrChildNum(index: roomIndex,increase: false,adult:adult);
              },
              child: const CircleAvatar(
                  child:  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: FaIcon(FontAwesomeIcons.minus),
                  ),),
            ),
          ],
        ),
      ],
    );
  }
}

class ContactDataInHotelBooking extends StatelessWidget {
  const ContactDataInHotelBooking({super.key,required this.width,required this.height,required this.onTap});
final double width;
final double height;
final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Contact Data',style: CustomTextStyle.resetPassTitle.copyWith(fontSize: 26),),
        const CustomTextFormField(label: 'Email',suffix: Icon(Icons.email),border: 10,),
        SizedBox(height: height*0.015,),
        CustomTwoFieldForm(
          firstCustomFormField:SizedBox(
              width: width*0.45,
              child: const CustomTextFormField(label: 'Phone',border: 10)) ,
          secondCustomFormField: SizedBox(
              width: width*0.45,
              child: const CustomTextFormField(label: 'Client Ref',border: 10)),
        ),
        SizedBox(height: height*0.015,),
        const CustomTextFormField(
          label: 'Remark.....',
          maxLines: 4,
        ),
        SizedBox(height: height*0.015,),
        Center(child: CustomLoginButton(label: 'Continue To Pay ',color: forthColor,altWidth: width*0.5,borderRadius: 12,onTap:onTap))
      ],
    );
  }
}

class PayInBookingView extends StatelessWidget {
  const PayInBookingView({super.key,required this.width,required this.height});
final double width;
final double height;
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      padding:const EdgeInsets.symmetric(horizontal: 15,).copyWith(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomGeneratedAiTripAppBar(height: height, width: width,appBarTitle: 'Payment',appBarStyle:CustomTextStyle.resetPassTitle),
          SizedBox(height: height*0.05,),
          const Text('Pay Safely',style: CustomTextStyle.privateTourTitle,),
          const Row(
            children: [
              Icon(Icons.document_scanner_outlined),
              SizedBox(width: 5,),
              Text('Scan Card'),
            ],
          ),
          SizedBox(height: height*0.02,),
          const CustomColumnWithTextForm(
            text: 'Name on Card ',
            customTextFormField: CustomTextFormField(label: 'Name',floatingLabelBehavior: FloatingLabelBehavior.never,),
          ),
          SizedBox(height: height*0.02,),
          const CustomColumnWithTextForm(
            text: 'Card Number',
            customTextFormField: CustomTextFormField(label: 'XXXX   XXXX   XXXX   XXXX',floatingLabelBehavior: FloatingLabelBehavior.never,),
          ),
          SizedBox(height: height*0.02,),
          CustomTwoFieldForm(
            firstText: 'Expiry Date',
            firstCustomFormField: SizedBox(
              width: width*0.4,
              child: const CustomTextFormField(label: 'MM/YY',floatingLabelBehavior: FloatingLabelBehavior.never,),),
            secondText: 'Security Code',
            secondCustomFormField: SizedBox(
              width: width*0.4,
              child: const CustomTextFormField(label: 'CVV',floatingLabelBehavior: FloatingLabelBehavior.never,),),
          ),
          SizedBox(height: height*0.1,),
          const Center(child: CustomLoginButton(borderRadius: 12,label: 'Pay & Book',color: forthColor,))
        ],
      ),
    );
  }
}

class PersonalDataInBookingView extends StatelessWidget {
  const PersonalDataInBookingView({super.key,required this.width,required this.height,required this.cubit});
final double width;
final double height;
final PaymentPersonalDataCubit cubit;
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 10).copyWith(bottom: 10),
      children: [
        CustomGeneratedAiTripAppBar(height: height, width: width,appBarTitle: 'Personal-Details',appBarStyle: CustomTextStyle.resetPassTitle,),
        SizedBox(height: height*0.02,),
        CustomTwoFieldForm(
          firstCustomFormField: SizedBox(
            width: width*0.45,
            child: CustomTextFormField(controller: cubit.holderFirstNameController,border: 10,label: 'First Name',floatingLabelBehavior: FloatingLabelBehavior.never,),
          ),
          secondCustomFormField: SizedBox(
            width: width*0.45,
            child: CustomTextFormField(controller: cubit.holderSurNameController,border: 10,label: 'Sur Name',floatingLabelBehavior: FloatingLabelBehavior.never,),
          ),
        ),
        SizedBox(height: height*0.01,),
        Text('Rooms',style: CustomTextStyle.resetPassTitle.copyWith(fontSize: 26),),
        SizedBox(
          height: height*0.5,
          child: ListView.separated(
              itemBuilder: (context,roomIndex){
                return BookedRoomItem(height: height, width: width,paxPayModel: cubit.payPaxList[roomIndex], changeAdultOrChildNum: (
                    {required bool adult,required bool increase, required int index}) { 
                  cubit.changeAdultOrChildNumInSpecificRoom(roomIndex: index, increase: increase, adult: adult);
                }, roomIndex: roomIndex,);
                },
              separatorBuilder: (context,index){
                return const SizedBox(height: 10,);
                }, itemCount:cubit.payPaxList.length),
        ),
        SizedBox(height: height*0.025,),
        ContactDataInHotelBooking(width: width, height: height,onTap: (){
          cubit.toggleBetweenPages(1);
        },),
      ],
    );
  }
}

