import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/features/tourist/google_map/presentaion/manager/map_cubit/google_map_cubit.dart';
import 'package:prepare_project/features/tourist/google_map/presentaion/view/model_bottom_sheet_with_details.dart';
class TextSearchWithResultList extends StatelessWidget {
  const TextSearchWithResultList({super.key,required this.width,required this.height,required this.cubit,required this.markers,required this.controller});
  final GoogleMapCubit cubit;
  final double height;
  final double width;
  final Set<Marker>? markers;
  final GoogleMapController?controller;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
        child: Column(
          children: [
            SizedBox(
              height:height*0.06,
              child: CustomTextFormField(
                label: 'Search here...',
                enableOutLine: false,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                suffix:const Icon(Icons.search_rounded,color: entertainmentColor,),
                prefix: const Icon(Icons.location_on_rounded,color:entertainmentColor),
                maxLines: 1,filled: true,fillColor: Colors.white,controller: cubit.textController,border: 25,onChanged: (value){
                cubit.getListOfTextSearch();
              },),
            ),
            const SizedBox(height:5,),
            cubit.textController.text.trim().isEmpty?
            const SizedBox():
            Container(
              width: width,
              height: height*0.25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: ListView.separated(
                  itemBuilder: (context,index){
                    return ListTile(
                      leading:const Icon(Icons.location_on,color: secondaryColor,)
                      ,title:Text(cubit.textSearchList[index].displayName??"") ,
                      trailing:IconButton(onPressed: ()async{
                        cubit.makeMarkerAndAnimateToNewPlace(index,markers: markers,controller: controller);
                        await showModalBottomSheet(context: context,
                            useSafeArea: true,
                            isScrollControlled: true,
                            builder: (context){
                          return PlaceDetailsWithSearchText(
                            onTap: (){
                              cubit.getListOfRoutes(index,).then((value) {
                                cubit.drawRoute(controller);
                              });
                          },height: height, width: width,model: cubit.textSearchList[index],);
                        });
                      }, icon: const Icon(Icons.arrow_forward)) ,);
                  },
                  separatorBuilder: (context,index){
                    return const Divider(height: 2,color: thirdColor,);
                  }, itemCount: cubit.textSearchList.length),

            )
          ],
        ),
      ),
    );
  }
}

