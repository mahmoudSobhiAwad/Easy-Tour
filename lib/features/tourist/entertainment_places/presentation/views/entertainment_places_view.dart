import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/entertainment_places/presentation/views/widgets/entertainment_place_item.dart';
import 'package:prepare_project/features/tourist/image_classification/presentation/views/widgets/container_back_icon.dart';
import 'package:prepare_project/features/tourist/tourist_home/data/model/home_data.dart';
class EntertainmentPlacesView extends StatelessWidget {
  const EntertainmentPlacesView({super.key});
  @override
  Widget build(BuildContext context) {
    double width=BasicDimension.screenWidth(context);
    double height=BasicDimension.screenHeight(context);
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top:height*0.035),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ContainerBackIcons(height: height, width: width, onPressed: (){Navigator.pop(context);}),
                const Text('Entertainment Places',style: CustomTextStyle.placesTitle,),
                const SizedBox(width: 20,),
              ],
            ),
          ),
          const Expanded(child: SizedBox()),
          SizedBox(
            height: height*0.85,
            child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 50,crossAxisSpacing: 30),
                itemCount: entertainmentItems.length,
                itemBuilder: (context,index)
                {
                  return EntertainmentPlaceItem(height: height,cardModel: entertainmentItems[index],);
                }
                ),
          ),
        ],
      ),
    );
  }
}
