import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/function/service_locator.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_app_bar_trip_generated.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/model/generated_trip_model.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/views/widgets/trip_details_widgets/hote_list.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/views/widgets/trip_details_widgets/restaurants_list.dart';
import 'package:prepare_project/features/tourist/google_map/presentaion/view/google_map_view.dart';
import 'package:prepare_project/features/tourist/nearby_places/data/models/nearby_places_model.dart';
import 'package:prepare_project/features/tourist/nearby_places/data/repos/nearby_places_repo_imp.dart';
import 'package:prepare_project/features/tourist/settings/presentaion/views/widgets/payment_setting_item.dart';
class ActivityDetailsView extends StatelessWidget {
  const ActivityDetailsView({super.key,required this.place});
  final Place place;
  @override
  Widget build(BuildContext context) {
    double width=BasicDimension.screenWidth(context);
    double height=BasicDimension.screenHeight(context);
    return BlocProvider(
      create: (context)=>ActivityDetailsCubit(placeLatLng: LatLng(place.latitude, place.longitude),nearbySearchRepoImp: getIt.get<NearbyPlacesRepoImpl>()),
      child: BlocConsumer<ActivityDetailsCubit,ActivityDetailsState>(builder: (context,state){
        var cubit=BlocProvider.of<ActivityDetailsCubit>(context);
        return Scaffold(
          body: Stack(
            children: [
              ListView(
                children: [
                  Image.network(place.image??"",errorBuilder: (context,_,s){
                    return const Icon(Icons.warning,color: closeColor,);
                  },width: width,height: height*0.45,fit: BoxFit.fill,),
                  SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(place.name,style: CustomTextStyle.fontBold18,),
                        ProfileSettingItem(
                          enableDivider: false,
                          rightWidget: const Text('Time Visiting',style:CustomTextStyle.fontNormal14WithEllipsis,),
                          child: Container(
                            padding:const EdgeInsets.all(5),
                            decoration: BoxDecoration(color: thirdColor,borderRadius: BorderRadius.circular(10)),
                            child:  Text(place.time??"",style: CustomTextStyle.fontNormal14WithEllipsis,),
                          ),),
                        Row(
                          children: [
                            const FaIcon(FontAwesomeIcons.ticket,color: entertainmentColor,),
                            SizedBox(width: width*0.025,),
                            Text('${place.budget} \$',style: CustomTextStyle.font14Light)
                          ],
                        ),
                        SizedBox(height: height*0.02,),
                        DefaultTabController(
                            initialIndex: 0,
                            length: 3,
                            child: TabBar(
                              padding: EdgeInsets.zero,
                              isScrollable: true,
                              onTap: (int index){
                                cubit.changeCurrIndex(index);
                              },
                                tabs:const [
                                  Text('Description'),
                                  Text('Nearby Hotels'),
                                  Text('Nearby Restaurants'),
                        ])),

                        SizedBox(height: height*0.02,),
                        [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            const Text('About Destination',style: CustomTextStyle.fontBold21,),
                            SizedBox(height: height*0.02,),
                            SizedBox(
                              height: height*0.2,
                              child: SingleChildScrollView(child:  Text(place.activity,style: CustomTextStyle.font14Light,)),
                            ),
                            SizedBox(height: height*0.02,),
                            Center(child: CustomLoginButton(altWidth: width*0.9,color: forthColor,label: 'Go Now',onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return GoogleMapView(initialInfo: place.name,initialLatLng: LatLng(place.latitude, place.longitude));
                              }));
                            },)),
                          ],
                        ),
                          cubit.isLoading?
                          const Center(child: CircularProgressIndicator()) :
                          HotelsListWithBar(height: height, width: width, hotels: cubit.hotelsList,),
                          cubit.isLoading?
                          const Center(child: CircularProgressIndicator()) :
                          RestaurantsListWithBar(height: height, width: width, restaurant: cubit.restList),
                        ][cubit.currIndex],
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0,left: 10,right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomContainerWithStroke(height: height, width: width, containWidget: IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon:const Icon(Icons.arrow_back_sharp))),
                    CustomContainerWithStroke(height: height, width: width, containWidget: IconButton(onPressed: (){
                    }, icon:const Icon(Icons.bookmark_border,))),
                  ],),
              ),
            ],
          ),
        );
      },
        listener: (context,state){},
      ),
    );
  }
}

class ActivityDetailsCubit extends  Cubit<ActivityDetailsState>{
  ActivityDetailsCubit({required this.placeLatLng,required this.nearbySearchRepoImp}):super(InitialActivityDetailsState());
  int currIndex=0;
  bool isLoading=true;
  List<NearbyPlacesModel>hotelsList=[];
  List<NearbyPlacesModel>restList=[];
  final NearbyPlacesRepoImpl nearbySearchRepoImp;
  final LatLng placeLatLng;
  void changeCurrIndex(int index)async{
    currIndex=index;
    emit(ChangeCurrIndexState());
    if(index==1){
      if(hotelsList.isEmpty){
        await getNearbyPlace('hotel');
      }
    }
    else if(index==2){
      if(restList.isEmpty){
      await getNearbyPlace('restaurant');
      }
    }
  }
  Future<void> getNearbyPlace(String type,)async{
    emit(LoadingGetHotelsOrRestState());
    isLoading=true;
    var response=await nearbySearchRepoImp.getNearbyPlace(NearbyPlacesModel().toJson(type:[type],long:placeLatLng.longitude,lat:placeLatLng.latitude,distance: 3000,maxResult: 3));
    return response.fold((failure){
      isLoading=false;
      emit(FailureGetHotelsOrRestState(errMessage: failure.errMessage));
    }, (places){
      if(type=='hotel'){
        hotelsList.clear();
        hotelsList.addAll(places);
      }
      else{
        restList.clear();
        restList.addAll(places);
      }
      isLoading=false;
      emit(SuccessGetHotelsOrRestState());
    });
  }


}
abstract class ActivityDetailsState {}

class InitialActivityDetailsState extends ActivityDetailsState {}
class ChangeCurrIndexState extends ActivityDetailsState {}
class LoadingGetHotelsOrRestState extends ActivityDetailsState {}
class SuccessGetHotelsOrRestState extends ActivityDetailsState {}
class FailureGetHotelsOrRestState extends ActivityDetailsState {
  final String?errMessage;
  FailureGetHotelsOrRestState({this.errMessage});
}
