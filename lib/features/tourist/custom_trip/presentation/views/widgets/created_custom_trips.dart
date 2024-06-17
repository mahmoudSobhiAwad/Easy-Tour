import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/delete_edit_photo.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_app_bar_trip_generated.dart';
import 'package:prepare_project/features/tourist/custom_trip/data/model/custom_trip_model.dart';
import 'package:prepare_project/features/tourist/custom_trip/presentation/manager/get_custom_trip/get_custom_trips_cubit.dart';
import 'package:prepare_project/features/tourist/custom_trip/presentation/views/widgets/custom_trip_view.dart';
import 'package:prepare_project/features/tourist/custom_trip/presentation/views/widgets/created_custom_trip_item.dart';
class CreatedCustomTripsBody extends StatelessWidget {
  const CreatedCustomTripsBody({super.key,required this.cubit});
  final GetCustomTripCubit cubit;
  @override
  Widget build(BuildContext context) {
    final double width=BasicDimension.screenWidth(context);
    final double height=BasicDimension.screenHeight(context);
    return Scaffold(
      floatingActionButton: CircleAvatar(
        backgroundColor: entertainmentColor,
        radius: width*0.075, 
        child: IconButton(
            iconSize: 40,
            onPressed:(){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return CustomTripView(customTripRepoImpl:cubit.customTripRepoImpl, cubit: cubit,customTripModel: CustomTripModel(),);
              }));
            },
            icon: const Icon(Icons.create_rounded,color: Colors.white,)),), 
      body: SafeArea(
          child:cubit.isLoading?const Center(child: CircularProgressIndicator()):
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: CustomGeneratedAiTripAppBar(height: height, width: width,appBarTitle: 'Custom Trips',),
              ),
              cubit.customTripList.isEmpty?const Center(child:  Text('Let\'s Create Your First Custom Trip',style: CustomTextStyle.fontBold30,textAlign: TextAlign.center,)) :
              Expanded(child: RefreshIndicator(
                onRefresh:()async{
                  cubit.getAllTrips();
                } ,
                child: ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: width*0.033,vertical:height*0.025,),
                        itemBuilder: (context,index) {
                          return GestureDetector(
                            onLongPress: (){
                              showDialog(context: context, builder: (context){
                                return DeleteOrEditPhoto(
                                    deleteImage: (){
                                      cubit.deleteTrip(index: index);
                                }, cropImage:()async{
                                      Navigator.push(context, MaterialPageRoute(builder: (context){
                                        return CustomTripView(customTripRepoImpl:cubit.customTripRepoImpl,customTripModel: cubit.customTripList[index], cubit: cubit,editOrCreate: true,);
                                  }));
                                });
                              });
                            },
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return CustomTripView(customTripRepoImpl:cubit.customTripRepoImpl,customTripModel: cubit.customTripList[index], cubit: cubit,editOrCreate: true,);
                                }));
                              },
                              child: CreatedCustomTripItem(width: width,height: height, customTripModel: cubit.customTripList[index],categoryList: cubit.getCategoriesList(index),));
                        }, separatorBuilder: (context,index){
                      return SizedBox(height: height*0.025,);
                    }, itemCount: cubit.customTripList.length),
              )),
            ],
          )
      ),
    );
  }
}