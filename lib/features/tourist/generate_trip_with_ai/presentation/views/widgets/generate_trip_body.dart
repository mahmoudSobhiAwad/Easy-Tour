import 'package:flutter/material.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_app_bar_trip_generated.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/manager/generate_trip_cubit.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/views/widgets/picked_places.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/views/widgets/select_num_of_activity.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/views/widgets/select_type_of_place.dart';

class GenerateTripBody extends StatelessWidget {
  const GenerateTripBody({super.key,required this.height,required this.width,required this.cubit});
  final double height;
  final double width;
  final GenerateAiTripCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset('assets/tourist_home/generate_trip_cover.jpg',fit: BoxFit.fitHeight,height: height*0.4,width: width,),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding:const EdgeInsets.all(20,).copyWith(right: 5,bottom: 0,left: 5),
            width: width,
            height: height*0.78,
            decoration:const BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(topLeft:Radius.circular(40) ,topRight:Radius.circular(40) )),
            child:ListView(
              padding: EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.bottom),
              children: [
                // SelectDateAndViewTripHistory(cubit: cubit, height: height, width: width),
                // const SizedBox(height: 12,),
                // CustomColumnWithTextForm(
                //   text: 'Number Of Place In Each Day',
                //   customTextFormField:  SizedBox(
                //     width: width*0.5,
                //     child: CustomTextFormField(
                //       controller: cubit.numberOfPlaceInDayController,
                //       maxLines: 1,
                //       align: TextAlign.center,
                //       fillColor: thirdColor,
                //       filled: true,
                //       prefix: const Padding(
                //         padding:  EdgeInsets.only(left: 5.0),
                //         child: CircleAvatar(radius: 20,backgroundColor: basicColor,child: Center(child: FaIcon(FontAwesomeIcons.minus,color: Colors.white,)),),
                //       ),
                //       suffix: const Padding(
                //         padding: EdgeInsets.only(right: 5.0),
                //         child: CircleAvatar(radius: 20,backgroundColor: basicColor,child: Center(child: Icon(Icons.add,color: Colors.white,)),),
                //       ),
                //     ),
                //   ),
                // ),
                const SizedBox(height: 12,),
                SelectTypesOfPlaces(height: height, width: width,typeOfTourismList: cubit.typeOfTourismList,changeToggle: (index){
                  cubit.toggleBetweenTypes(index);
                },),
                const SizedBox(height: 12,),
                PlacesWrapWidget(cubit: cubit,width: width,height: height,),
                const SizedBox(height: 12,),
                SelectNumOfActivityInDay(width: width, height: height,currActivity: cubit.currActivity ,activityNames: cubit.activityNames,changeActivity: (int index) {
                  cubit.changeActivityIndex(index);
                },),
                const SizedBox(height: 20,),
                Center(
                    child:  CustomLoginButton(isLoading: cubit.isLoading,color: Colors.black,label:'Generate A Trip',altWidth: width*0.5,onTap: (){
                      cubit.requestGenerateTrip();
                      },
                    )
                ),
                const SizedBox(height: 20,),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0,left: 15),
          child: Align(
              alignment: Alignment.topLeft,
              child: CustomGeneratedAiTripAppBar(height: height, width: width)),
        ),
      ],
    );
  }
}










