import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_app_bar_trip_generated.dart';
import 'package:prepare_project/features/tourist/nearby_places/presentation/manager/search_nearby_cubit.dart';
import 'package:prepare_project/features/tourist/nearby_places/presentation/manager/search_nearby_state.dart';
import 'package:prepare_project/features/tourist/nearby_places/presentation/views/widgets/one_category_search.dart';
import 'package:prepare_project/features/tourist/nearby_places/presentation/views/widgets/pick_category_widget.dart';

class NearbySearchView extends StatelessWidget {
  const NearbySearchView({super.key,this.showBackIcon=true});
  final bool showBackIcon;
  @override
  Widget build(BuildContext context) {
    final double height=BasicDimension.screenHeight(context);
    final double width=BasicDimension.screenWidth(context);
    return BlocProvider(
        create: (context)=>NearbySearchCubit(),
      child: BlocBuilder<NearbySearchCubit,NearbySearchState>(builder: (context,state)
      {
        var cubit = BlocProvider.of<NearbySearchCubit>(context);
        return Scaffold(
          backgroundColor:const Color(0xffF7F7F9),
          body: Padding(
            padding: const EdgeInsets.only(top:30,left: 10),
            child: Column(
              children: [
                CustomGeneratedAiTripAppBar(height: height, width: width,appBarTitle: 'Nearby Places',showBackIcon: showBackIcon,),
                PickCategoryForSearch(height: height, width: width,typeOfCategory:cubit.typeOfCategories,pickCategory: (index){
                  cubit.changePickedCategory(index);
                },),
                Expanded(
                  child: SizedBox(
                    height: height*0.6,
                    child:cubit.typesOfList.isEmpty?
                    const Center(child: Text('Pick Category To Search For It',textAlign: TextAlign.center,style: CustomTextStyle.homePartTitle,),) :
                    ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: cubit.typesOfList.length,
                        physics:const BouncingScrollPhysics(),
                        itemBuilder: (context,index){
                          return OneCategorySearchItem(height: height, width: width,type: cubit.typesOfList[index],);
                        }),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}





