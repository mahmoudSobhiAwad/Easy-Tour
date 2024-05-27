import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/function/service_locator.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_container.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_types.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_app_bar_trip_generated.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/models/get_hotel_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/repos/get_hotels_repo/get_hotels_repo_impl.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/manager/hotel_booking_cubit/hotel_booking_cubit.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/manager/hotel_booking_cubit/hotel_booking_state.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/available_rooms/availabile_room_view.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/date_range_pass_num_destination.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/hotel_result/one_hotel_item_in_result.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/show_dest_search_menu.dart';

class HotelResultView extends StatelessWidget {
  const HotelResultView({super.key,required this.hotelList,required this.destName,});
final List<HotelsModel> hotelList;
final String destName;
 @override
  Widget build(BuildContext context) {
    final double width=BasicDimension.screenWidth(context);
    final double height=BasicDimension.screenHeight(context);
    return BlocProvider(create: (context)=>HotelBookingCubit(hotelList: hotelList,hotelsRepoImpl: getIt.get<GetHotelsRepoImpl>(),destName: destName),
        child: BlocConsumer<HotelBookingCubit,HotelBookingStates>(
            builder: (context,state){
              var cubit=BlocProvider.of<HotelBookingCubit>(context);
              return WillPopScope(
                onWillPop: ()async{
                  if(cubit.showOccupancies){
                    cubit.showOrClosePickOccupancies();
                    return false;
                  }
                  return true;
                },
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: SafeArea(
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: CustomGeneratedAiTripAppBar(height: height, width: width,appBarTitle: '$destName:Hotels',appBarStyle: CustomTextStyle.privateTourTitle,),
                            ),
                            SizedBox(height: height*0.025,),
                            DateWithPassengerNumbersWithPlace(height: height, width: width,onSearch: (){}, cubit: cubit,),
                            SizedBox(height: height*0.025,),
                            Expanded(
                              child: ListView.separated(
                                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                  itemBuilder: (context,index){
                                    return OneHotelItemInBooking(width: width, height: height,model: hotelList[index],onTap: (){
                                      cubit.searchForAvailableRooms(hotelCode: hotelList[index].code!, hotelIndex: index);
                                    },);
                                  }, separatorBuilder: (context,index){
                                return SizedBox(height: height*0.025,);
                              }, itemCount: hotelList.length),
                            ),
                          ],
                        ),
                        cubit.searchResults.isNotEmpty&&cubit.searchText.text.trim().isNotEmpty&&cubit.showList?
                        ShowResultOfDestSearch(
                            top: height*0.22,
                            height: height, width: width, onTapMenu: (result){
                          cubit.onTapOnMenu(result);
                        }, searchResults: cubit.searchResults):
                        const SizedBox(),
                        cubit.showOccupancies?
                        Align(
                          alignment: Alignment.bottomCenter,
                            child: OccupanciesWidget(cubit: cubit, width: width,height: height,)) :
                        const SizedBox(),
                      ],
                    ),
                  ),
                ),
              );
            },
            listener: (context,state){
              if(state is SuccessGetAvailableRooms){
                Navigator.push(context,MaterialPageRoute(builder: (context){
                  return RoomAvailabilityView(model: state.model,);
                }));
              }
              else if(state is FailureGetAvailableRooms){
                showDialog(context: context, builder: (context)=> ContainerAlertWidget(
                  types: AlertTypes.failed,
                  onTap: (){
                    Navigator.pop(context);
                  },
                  content: '${state.errMessage}',));
              }
            }),
    );
  }
}




