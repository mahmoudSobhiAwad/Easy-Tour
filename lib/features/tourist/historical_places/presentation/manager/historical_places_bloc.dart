import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/model/generated_trip_model.dart';
import 'package:prepare_project/features/tourist/historical_places/presentation/manager/historical_places_states.dart';
import 'package:prepare_project/features/tourist/tourist_home/data/repo/home_tourist_repo_impl.dart';

class DiscoverPlacesCubit extends Cubit<DiscoverPlacesStates>{
  DiscoverPlacesCubit({required this.homeTouristRepoImp,this.initialList}):super(InitialHistoricalPlacesState());
  bool isFav=false;
  List<Place>places=[];
  List<Place>?initialList;
  String?currCategory;
  final HomeTouristRepoImp homeTouristRepoImp;
  int currIndex=0;
  List<int>paginationList=[1,2,3,4,5,6,7,8,9,10];
  ScrollController scrollController=ScrollController();
  void changeIndex(int index)async{
    currIndex=index;
    emit(ChangePaginationIndexState());
    await getPlaces();
  }
  void scrollToNextItem({bool isPrevious = false,required double width}) async{
    if(currIndex<paginationList.length-1){
      double offset = (currIndex+ 1) * width;
      currIndex++;
      scrollController.animateTo(
         offset,
         duration: const Duration(milliseconds: 500),
         curve: Curves.easeInOut,);
      emit(ChangePaginationIndexState());
    }
   await getPlaces();
  }
  void scrollToPrevItem({bool isPrevious = false,required double width})async {
    if(currIndex>0){
      double offset = (currIndex- 1) * width;
      currIndex--;
      scrollController.animateTo(
         offset,
         duration: const Duration(milliseconds: 500),
         curve: Curves.easeInOut,);
      emit(ChangePaginationIndexState());
    }
    await getPlaces();
  }
  Future<void>getPlaces()async{
    places.clear();
    emit(LoadingGetPlacesState());
    var result=await homeTouristRepoImp.getBestDestination(category:currCategory,maxLength: 20,pageNum: currIndex+1);
    result.fold(
            (failure){
          emit(FailureGetPlacesState(errMessage: failure.errMessage));
        },
            (placesList){
              for(var item in placesList){
                places.add(item);
              }
              emit(SuccessGetPlacesState());
              initListToPickForCustom();
        });
  }
  void changeCategory(String? selectedCat)async{
    currCategory=selectedCat!;
    await getPlaces();

  }
  void initListToPickForCustom() {
    if (initialList != null && initialList!.isNotEmpty) {
      for (var place in places) {
        place.picked = initialList!.any((item) => item.name == place.name);
      }
      emit(InitPickedPlacesListState());
    }
  }
  void changePicking(int index){
    if(places[index].picked){
      places[index].picked=false;
      initialList!.remove(places[index]);
    }
    else{
      places[index].picked=true;
      initialList!.add(places[index]);
    }
    emit(ChangePickingPlacesState());
  }
}
