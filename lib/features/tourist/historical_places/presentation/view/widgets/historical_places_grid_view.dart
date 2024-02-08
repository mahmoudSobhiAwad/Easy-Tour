import 'package:flutter/material.dart';
import 'package:prepare_project/features/tourist/historical_places/presentation/view/widgets/historical_place_details_view.dart';
import 'package:prepare_project/features/tourist/historical_places/presentation/view/widgets/historical_places_item.dart';

class HistoricalPlacesGrid extends StatelessWidget {
  const HistoricalPlacesGrid({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: height*0.7,
        child: GridView.builder(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            itemCount: 20,
            padding:const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            physics:const BouncingScrollPhysics(),
            gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing:20 ,mainAxisSpacing:20 ,childAspectRatio: .8),
            itemBuilder: (context,index){
              return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return HistoricalPlaceDetails(height: height, width: width);
                    }));
                  },
                  child: HistoricalPlaceItem(height: height*0.25, width: width*0.4));
            }
        ),
      ),
    );
  }
}
