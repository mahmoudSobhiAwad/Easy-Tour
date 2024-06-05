import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_app_bar_trip_generated.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/two_beside_form.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/manager/payment_personal_data_cubit/payment_personal_data_cubit.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/personal_payment/booked_room_item.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/personal_payment/contact_data_for_paying.dart';
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
            child: CustomTextFormField(
              controller: cubit.holderFirstNameController,border: 10,label: 'First Name',floatingLabelBehavior: FloatingLabelBehavior.never,),
          ),
          secondCustomFormField: SizedBox(
            width: width*0.45,
            child: CustomTextFormField(controller: cubit.holderSurNameController,border: 10,label: 'Sur Name',floatingLabelBehavior: FloatingLabelBehavior.never,),
          ),
        ),
        SizedBox(height: height*0.01,),
        Text('Rooms',style: CustomTextStyle.resetPassTitle.copyWith(fontSize: 26),),
        SizedBox(
          height: cubit.payPaxList.length>1?height*0.5:height*0.3,
          child: ListView.separated(
              itemBuilder: (context,roomIndex){
                return BookedRoomItem(
                  cubit: cubit,
                  height: height,
                  width: width,
                  roomIndex: roomIndex,
                );
              },
              separatorBuilder: (context,index){
                return const SizedBox(height: 10,);
              }, itemCount:cubit.payPaxList.length),
        ),
        SizedBox(height: height*0.025,),
        ContactDataInHotelBooking(width: width, height: height,cubit:cubit),
      ],
    );
  }
}