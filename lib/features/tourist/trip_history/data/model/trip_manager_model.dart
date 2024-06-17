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
      customTripsList:json['customTrips']!=null? List<CustomTripModel>.from(json['customTrips'].map((x) => CustomTripModel.fromJson(x))):[],
      generatedTripsList:json['AITrips']!=null? List<GeneratedTripModel>.from(json['AITrips'].map((x) => GeneratedTripModel.fromHistory(x))):[],
      tripsWithTourGuideList:json['tourGuideTrips']!=null? List<Trip>.from(json['tourGuideTrips'].map((x) => Trip.fromJson(x))):[],
    );
  }
}