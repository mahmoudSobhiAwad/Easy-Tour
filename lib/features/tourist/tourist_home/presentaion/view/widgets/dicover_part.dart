import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/model/generated_trip_model.dart';
import 'package:prepare_project/features/tourist/historical_places/presentation/view/historical_places_view.dart';
import 'package:prepare_project/features/tourist/historical_places/presentation/view/widgets/best_destination_item.dart';
import 'package:prepare_project/features/tourist/historical_places/presentation/view/widgets/best_destination_with_loading.dart';
import 'package:prepare_project/features/tourist/tourist_home/data/repo/home_tourist_repo_impl.dart';
import '../../../../generate_trip_with_ai/presentation/views/widgets/activity_deatils/activity_details_view.dart';


class DiscoverPart extends StatelessWidget {
  const DiscoverPart({
    super.key,
    required this.height,
    required this.width,
    required this.isMenuActive,
    required this.places,
    required this.homeTouristRepoImp,
  });

  final double height;
  final double width;
  final bool isMenuActive;
  final List<Place>places;
  final HomeTouristRepoImp homeTouristRepoImp;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Best Destinations',style: CustomTextStyle.homePartTitle,),
            GestureDetector(
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context){
                  return  const DiscoverPLacesView();
                }));
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Text('See All',style: CustomTextStyle.fontNormal14WithEllipsis,),
              ),
            ),
          ],
        ),
        SizedBox(
            height:height*0.3,
            width:width,
            child: ListView.separated(
              padding: EdgeInsets.zero,
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              itemCount:places.isEmpty?2:places.length,
              physics: isMenuActive?const NeverScrollableScrollPhysics():const BouncingScrollPhysics(),
              separatorBuilder: (context,index){
                return const SizedBox(width: 20,);
                },
              itemBuilder: (BuildContext context, int index)
              {
                return places.isEmpty? LoadingBestDestinationItem(height: height, width: width):GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return ActivityDetailsView(place:  places[index],);
                      }));
                    },
                    child: BestDestinationItem(height: height, width: width,place: places[index],));
                },
            )
        ),
      ],
    );
  }
}

