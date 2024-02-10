import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/delete_edit_photo.dart';
import 'package:prepare_project/features/tour_guide/private_tour/presentation/manager/tour_cubit/private_tour_cubit.dart';
import 'package:prepare_project/features/tour_guide/private_tour/presentation/view/widgets/create_edit_tour_view.dart';
import 'package:prepare_project/features/tour_guide/private_tour/presentation/view/widgets/create_or_edit_tour_body.dart';
import 'package:prepare_project/features/tour_guide/private_tour/presentation/view/widgets/private_tour_item.dart';
class PrivateToursListBody extends StatelessWidget {
  const PrivateToursListBody({
    super.key,
    required this.height,
    required this.cubit,
    required this.width,
  });

  final double height;
  final PrivateTourCubit cubit;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        cubit.tripsList.isEmpty?const Center(child:Text('You Don\'t Add Any Trip, Let\'s Add Some',style: CustomTextStyle.placesTitle,textAlign: TextAlign.center,),):
        Column(
          children: [
            Container(
              padding:const EdgeInsets.only(top:20 ),
              color: thirdColor,
              height: height*0.1,
              child:const Center(child:  Text('My Trips',style: CustomTextStyle.commonSignDark,)),
            ),
            Expanded(
              child: RefreshIndicator(
                color: basicColor,
                backgroundColor: thirdColor,
                onRefresh: ()async{
                  cubit.getAllMyTrip();
                },
                child: ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: cubit.tripsList.length,
                  itemBuilder: (context,index){
                    return GestureDetector(
                      onLongPress: (){
                        showDialog(context: context, builder: (context){
                          return DeleteOrEditPhoto(deleteImage: (){
                            cubit.deleteSpecificTrip(index);
                          }, cropImage:()async{
                            Navigator.push(context, MaterialPageRoute(builder:(context)=> CreateOrEditPrivateTourView(
                              privateCubit: cubit,
                              tourList: cubit.tripsList[index],
                              createOrEdit: CreateOrEdit.edit,
                              editedTourIndex: index,
                              model: cubit.tripsList[index],
                              appBarTitle: 'Edit My Trip',)));
                          });
                        });
                      },
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder:(context)=> CreateOrEditPrivateTourView(
                            privateCubit: cubit,
                            tourList: cubit.tripsList[index],
                            createOrEdit: CreateOrEdit.edit,
                            editedTourIndex: index,
                            model: cubit.tripsList[index],
                            appBarTitle: 'Edit My Trip',)));
                        },
                        child:Stack(
                          alignment: Alignment.center,
                          children: [
                            PrivateTourItem(height: height, width: width,model:cubit.tripsList[index],),
                            cubit.removeLoading?const CircularProgressIndicator():const SizedBox(),
                          ],
                        ));
                  },
                ),
              ),
            ),
          ],
        ),
        Positioned(
            left: width*0.8,
            bottom: height*0.1,
            child: GestureDetector(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return  CreateOrEditPrivateTourView(appBarTitle: 'Create A Tour',createOrEdit: CreateOrEdit.create,privateCubit: cubit,);
                  }));
                },
                child: CircleAvatar(radius: height*0.04,backgroundColor: thirdColor,child:const Icon(Icons.mode_edit_outline_rounded,color: basicColor,size: 35,),))),
      ],
    );
  }
}