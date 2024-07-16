import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/function/service_locator.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_app_bar_trip_generated.dart';
import 'package:prepare_project/features/tourist/nearby_places/data/repos/nearby_places_repo_imp.dart';
import 'package:prepare_project/features/tourist/nearby_places/presentation/manager/search_nearby_cubit.dart';
import 'package:prepare_project/features/tourist/nearby_places/presentation/manager/search_nearby_state.dart';
import 'package:prepare_project/features/tourist/nearby_places/presentation/views/widgets/pick_category_widget.dart';

class NearbySearchView extends StatelessWidget {
  const NearbySearchView({super.key,this.showBackIcon=true});
  final bool showBackIcon;
  @override
  Widget build(BuildContext context) {
    final double height=BasicDimension.screenHeight(context);
    final double width=BasicDimension.screenWidth(context);
    // return VideoTest();
    return BlocProvider(
        create: (context)=>NearbySearchCubit(nearbySearchRepoImp: getIt.get<NearbyPlacesRepoImpl>()),
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
                     Center(child: Text('Pick Category To Search For It',textAlign: TextAlign.center,style: CustomTextStyle.fontGrover30,),) :
                    ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: cubit.typesOfList.length,
                        physics:const BouncingScrollPhysics(),
                        itemBuilder: (context,index){
                          return GestureDetector(
                              onTap: [()async{
                                await cubit.getNearbyPlaces();
                              },][index],
                          //    child: OneCategorySearchItem(height: height, width: width,type: cubit.typesOfList[index],)
                          );
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




// class VideoTest extends StatefulWidget {
//   const VideoTest({Key? key}) : super(key: key);
//
//   @override
//   State<VideoTest> createState() => _MyVideoTest();
// }
//
// class _MyVideoTest extends State<VideoTest> {
//   late CachedVideoPlayerController _videoPlayerController,
//       _videoPlayerController2,
//       _videoPlayerController3;
//
//   late CustomVideoPlayerController _customVideoPlayerController;
//   // late CachedVideoPlayerController videoPlayerController;
//   late CustomVideoPlayerWebController _customVideoPlayerWebController;
//
//   final CustomVideoPlayerSettings _customVideoPlayerSettings =
//   const CustomVideoPlayerSettings(showSeekButtons: true);
//
//   final CustomVideoPlayerWebSettings _customVideoPlayerWebSettings =
//   CustomVideoPlayerWebSettings(
//     src: longVideo,
//   );
//
//   @override
//   void initState() {
//     super.initState();
//     // _videoPlayerController = CachedVideoPlayerController.file(File('videoUrl'))
//     //   ..initialize().then((value) => setState(() {}));
//     _videoPlayerController = CachedVideoPlayerController.network(
//       longVideo,
//     )..initialize().then((value) => setState(() {}));
//     _videoPlayerController2 = CachedVideoPlayerController.network(video240);
//     _videoPlayerController3 = CachedVideoPlayerController.network(video480);
//     _customVideoPlayerController = CustomVideoPlayerController(
//       context: context,
//       videoPlayerController: _videoPlayerController,
//       customVideoPlayerSettings: _customVideoPlayerSettings,
//       additionalVideoSources: {
//         "240p": _videoPlayerController2,
//         "480p": _videoPlayerController3,
//         "720p": _videoPlayerController,
//       },
//     );
//
//     _customVideoPlayerWebController = CustomVideoPlayerWebController(
//       webVideoPlayerSettings: _customVideoPlayerWebSettings,
//     );
//   }
//
//   @override
//   void dispose() {
//     _customVideoPlayerController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return CupertinoPageScaffold(
//       navigationBar: const CupertinoNavigationBar(
//         middle: Text("Appinio Video Player"),
//       ),
//       child: SafeArea(
//         child: ListView(
//           physics: const NeverScrollableScrollPhysics(),
//           children: [
//           CustomVideoPlayer(
//               customVideoPlayerController: _customVideoPlayerController,
//             ),
//             CupertinoButton(
//               child: const Text("Play Fullscreen"),
//               onPressed: () {
//                 if (kIsWeb) {
//                   _customVideoPlayerWebController.setFullscreen(true);
//                   _customVideoPlayerWebController.play();
//                 } else {
//                   _customVideoPlayerController.setFullscreen(true);
//                   _customVideoPlayerController.videoPlayerController.play();
//                 }
//               },
//             ),
//             IconButton(onPressed: (){
//               ImagePicker().pickVideo(source: ImageSource.gallery);
//             },icon:Icon(CupertinoIcons.photo)),
//           ],
//         ),
//       ),
//     );
//   }
// }

String videoUrlLandscape =
    "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4";
String videoUrlPortrait =
    'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4';
String longVideo =
    "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";

String video720 =
    "https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_10mb.mp4";

String video480 =
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4";

String video240 =
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4";



