import 'package:intl/intl.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/model/generated_trip_model.dart';

class CustomTripModel{
  String ? title;
  String ? tripId;
  String ? startDate;
  String ? endDate;
  int ?durationNum;
  List<CustomTripDetailsModel>?tripDetailsList;
  CustomTripModel({this.title,this.endDate,this.startDate,this.tripDetailsList,this.tripId,this.durationNum});

  factory CustomTripModel.fromJson(Map<String,dynamic>json){
    return CustomTripModel(
      title: json['title'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      tripId: json['_id'],
      durationNum:(json['startDate']!=null||json['endDate']!=null)?DateFormat('d MMM y').parse(json['endDate']).difference(DateFormat('d MMM y').parse(json['startDate'])).inDays:null,
      tripDetailsList: json['tripDetails']!=null?(json['tripDetails']as List).map((tripDetails) => CustomTripDetailsModel.fromJson(tripDetails)).toList():null,
    );
  }

  Map<String,dynamic>toJson(){
    return {
      "title": title,
      "startDate": startDate,
      "endDate": endDate,
      "tripDetails":[
        ...List.generate(tripDetailsList?.length??0, (index) => tripDetailsList?[index].toJson())
      ]
    };
  }
}
class CustomTripDetailsModel{
  String ? dayName;
  List<Place>?daysDetailsList;
  CustomTripDetailsModel({this.daysDetailsList,this.dayName});

  factory CustomTripDetailsModel.fromJson(Map<String,dynamic>json){
    return CustomTripDetailsModel(
      dayName: json['dayName'],
      daysDetailsList:json['dayPlaces']!=null?(json['dayPlaces']as List).map((dayDetails) => Place.fromCustomTripJson(dayDetails)).toList():null,
    );
  }
  Map<String,dynamic>toJson(){
    return {
      "dayName": dayName,
      "dayPlaces":[
        ...List.generate(daysDetailsList?.length??0, (index) =>daysDetailsList?[index].toCustomTripJson()),
      ],
    };
  }


}
// class DaysInCustomTripDetails{
//   String ? placeName;
//   num ? lat;
//   num ? long;
//   String ? category;
//   String ? government;
//   String ? image;
//   String ? activity;
//   String ? priceRange;
//   DaysInCustomTripDetails({this.image,this.category,this.activity,this.government,this.lat,this.long,this.placeName,this.priceRange});
//
//   factory DaysInCustomTripDetails.fromJson(Map<String,dynamic>json){
//     return DaysInCustomTripDetails(
//       placeName: json['placeName'],
//       lat: json['latitude'],
//       long: json['longitude'],
//       category: json['category'],
//       government: json['government'],
//       image: json['image'],
//       activity: json['activity'],
//       priceRange: json['priceRange'],
//     );
//   }
//
//   Map<String,dynamic>toCustomTripJson(){
//     return {
//       "placeName": placeName,
//       "latitude": lat,
//       "longitude": long,
//       "category": category,
//       "government": government,
//       "image": image,
//       "activity": activity,
//       "priceRange": priceRange,
//     };
//   }
// }
