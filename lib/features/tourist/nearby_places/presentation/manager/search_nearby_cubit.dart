import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/model/type_of_places_toursim.dart';
import 'package:prepare_project/features/tourist/nearby_places/data/models/nearby_places_model.dart';
import 'package:prepare_project/features/tourist/nearby_places/data/repos/nearby_places_repo_imp.dart';
import 'package:prepare_project/features/tourist/nearby_places/presentation/manager/search_nearby_state.dart';

class NearbySearchCubit extends Cubit<NearbySearchState>{
  NearbySearchCubit({required this.nearbySearchRepoImp}):super(InitialNearbySearchState());
  final NearbyPlacesRepoImpl nearbySearchRepoImp;
  List<TypeOfTourism>typeOfCategories=[
    TypeOfTourism(typeImage: 'assets/entertainment_places/food.png', typeName: 'Restaurants', picked: false),
    TypeOfTourism(typeImage: 'assets/entertainment_places/beach_places.png', typeName: 'beach&Sea', picked: false),
    TypeOfTourism(typeImage: 'assets/entertainment_places/cinema.png', typeName: 'Cinemas', picked: false),
    TypeOfTourism(typeImage: 'assets/entertainment_places/food.png', typeName: 'Restaurants', picked: false),
    TypeOfTourism(typeImage: 'assets/entertainment_places/beach_places.png', typeName: 'beach&Sea', picked: false),
    TypeOfTourism(typeImage: 'assets/entertainment_places/cinema.png', typeName: 'Cinemas', picked: false),
  ];
  List<String>typesOfList=[];
  void changePickedCategory(int index){
    if(typeOfCategories[index].picked==true){
      typeOfCategories[index].picked=false;
      typesOfList.remove(typeOfCategories[index].typeName);
    }
    else{
      typeOfCategories[index].picked=true;
      typesOfList.add(typeOfCategories[index].typeName);
    }
    emit(ChangeCategoryPickedSearchState());
  }
  Future<void>getNearbyPlaces()async{
    emit(LoadingGetNearbyPlacesState());
    var response=await nearbySearchRepoImp.getNearbyPlace(NearbyPlacesModel().toJson(type:['restaurant'],long:32.65662139529527 ,lat:25.720063225758317 ,distance: 700,maxResult: 3));
    return response.fold((failure){
      log(failure.errMessage.toString());
      emit(FailureGetNearbyPlacesState(errMessage: failure.errMessage));
    }, (places){
      emit(SuccessGetNearbyPlacesState());
    });
  }

}