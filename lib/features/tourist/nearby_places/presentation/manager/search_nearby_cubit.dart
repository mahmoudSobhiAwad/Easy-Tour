import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/model/type_of_places_toursim.dart';
import 'package:prepare_project/features/tourist/nearby_places/presentation/manager/search_nearby_state.dart';

class NearbySearchCubit extends Cubit<NearbySearchState>{
  NearbySearchCubit():super(InitialNearbySearchState());
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

}