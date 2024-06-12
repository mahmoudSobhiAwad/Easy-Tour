import 'package:prepare_project/features/tour_guide/private_tour/data/model/private_tour_model.dart';
import 'package:prepare_project/features/tourist/custom_trip/data/model/custom_trip_model.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/model/generated_trip_model.dart';

class TripManagerModel{
  List<CustomTripModel> customTripsList;// no need to change any thing
  List<GeneratedTripModel> generatedTripsList;/// need to change the base model not day model
  List<Trip> tripsWithTourGuideList;
  TripManagerModel({required this.customTripsList,required this.generatedTripsList,required this.tripsWithTourGuideList});
  factory TripManagerModel.fromJson(Map<String,dynamic>json){
    return TripManagerModel(
      customTripsList: List<CustomTripModel>.from(json['trips'].map((x) => Trip.fromJson(x))),
      generatedTripsList: List<GeneratedTripModel>.from(json['trips'].map((x) => Trip.fromJson(x))),
      tripsWithTourGuideList: List<Trip>.from(json['trips'].map((x) => Trip.fromJson(x))),
    );
  }
}