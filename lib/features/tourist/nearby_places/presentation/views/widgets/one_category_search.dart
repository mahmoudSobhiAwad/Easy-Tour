import 'package:flutter/material.dart';
import 'package:prepare_project/features/tourist/nearby_places/data/models/nearby_places_model.dart';
import 'package:prepare_project/features/tourist/nearby_places/presentation/views/widgets/small_search_item.dart';

class OneCategorySearchItem extends StatelessWidget {
  const OneCategorySearchItem({
    super.key,
    required this.height,
    required this.width,
    required this.listModel,
  });

  final double height;
  final double width;
  final List<NearbyPlacesModel> listModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: SizedBox(
        height: height*0.35,
        child: ListView.separated(
            clipBehavior: Clip.none,
            physics:const BouncingScrollPhysics(),
            separatorBuilder: (context,index)=>const SizedBox(width: 20,),
            itemBuilder:(context,index){
              return OneSearchSmallItem(height: height, width: width, model: listModel[index],);
            }
            ,scrollDirection: Axis.horizontal,
            itemCount: listModel.length),
      ),
    );
  }
}