import 'package:intl/intl.dart';

class GetTicketsModel{
  String? lastTicketTime;
  bool instantBooking;
  int? avaSeats;
  String? price;
  Itineraries? goingItinerariesList;
  Itineraries?returnItinerariesList;
  OriginDestinations?goingTrip;
  List<String>?travelersTypes;
  String cabinType;
  GetTicketsModel({this.price,this.instantBooking=false,this.avaSeats,this.lastTicketTime,this.goingItinerariesList,this.returnItinerariesList,this.goingTrip,this.travelersTypes,this.cabinType='BUSINESS'});
  factory GetTicketsModel.fromJson(Map<String,dynamic>json,bool check){
    return GetTicketsModel(
      price: json['price']['grandTotal'],
      lastTicketTime: json['lastTicketingDate'],
      instantBooking: json['instantTicketingRequired'],
      goingItinerariesList: Itineraries.fromJson(json['itineraries'][0],),
      returnItinerariesList:check?Itineraries.fromJson(json['itineraries'][1],):null,
    );
  }



  Map<String,dynamic>toJson(){
    return {
      "currencyCode": "USD",
      "originDestinations":[
        {
          "id": "1",
          "originLocationCode": "${goingTrip?.originIatCode}",
          "destinationLocationCode": "${goingTrip?.departureIatCode}",
          "departureDateTimeRange": {
            "date": "${goingTrip?.departureLeaveTime}"
          }
        },
        if(goingTrip?.departureReturnTime!=null) {
          "id": "2",
          "originLocationCode": "${goingTrip?.departureIatCode}",
          "destinationLocationCode": "${goingTrip?.originIatCode}",
          "departureDateTimeRange": {
            "date": "${goingTrip?.departureReturnTime}"
          }
        },

      ],
      "travelers": [...List.generate(travelersTypes?.length??0, (index) => {
        'id':(index+1).toString(),
        'travelerType':travelersTypes?[index],
      }),],
      "sources": [
        "GDS"
      ],
      "searchCriteria": {
        "maxFlightOffers": 3,
        "flightFilters": {
          "cabinRestrictions": [
            {
              "cabin": cabinType,
              "originDestinationIds": [
                "1"
              ],
            }
          ]
        }
      }
    };
  }

}



class Itineraries{
  String duration;
  List<Segments> segments;
  Itineraries({required this.duration,required this.segments});

  factory Itineraries.fromJson(Map<String,dynamic>json){
    List<Segments>segmentsList=[];
    for(var item in json['segments']){
      segmentsList.add(Segments.fromJson(item));
    }

    return Itineraries(
        duration: parseDuration(json['duration']),
        segments: segmentsList);
  }
}
class Segments{
  DepartureOrLeaveOfSegments departureSeg;
  DepartureOrLeaveOfSegments arrivalSeg;
  String partDuration;
  Segments({required this.arrivalSeg,required this.departureSeg,required this.partDuration});
  
  factory Segments.fromJson(Map<String,dynamic>json){
    return Segments(
        partDuration: parseDuration(json['duration'],),
        arrivalSeg: DepartureOrLeaveOfSegments.fromJson(json['arrival']),
        departureSeg: DepartureOrLeaveOfSegments.fromJson(json['departure']));
  }
  
}

class DepartureOrLeaveOfSegments{
  String iatCode;
  String timeToLeave;
  DepartureOrLeaveOfSegments({required this.iatCode,required this.timeToLeave});
  factory DepartureOrLeaveOfSegments.fromJson(Map<String,dynamic>json){
    return DepartureOrLeaveOfSegments(
      iatCode: json['iataCode'],
      timeToLeave: DateFormat('d MMM yyyy h:mm a').format(DateTime.parse(json['at'])),);
  }
}
class OriginDestinations{
  String ? originIatCode;
  String ? departureIatCode;
  String ? departureLeaveTime;
  String ? departureReturnTime;
  OriginDestinations({required this.departureIatCode,required this.departureLeaveTime,required this.originIatCode,this.departureReturnTime});
}

String parseDuration(String duration) {
  final regex = RegExp(r'PT(?:(\d+)H)?(?:(\d+)M)?(?:(\d+)S)?');
  final match = regex.firstMatch(duration);

  if (match != null) {
    final hours = int.tryParse(match.group(1) ?? '0') ?? 0;
    final minutes = int.tryParse(match.group(2) ?? '0') ?? 0;
    final seconds = int.tryParse(match.group(3) ?? '0') ?? 0;

    final duration = Duration(hours: hours, minutes: minutes, seconds: seconds);
    return formatDuration(duration);
  } else {
    return 'Invalid Duration';
  }
}

String formatDuration(Duration duration) {
  final hours = duration.inHours;
  final minutes = duration.inMinutes.remainder(60);
  final seconds = duration.inSeconds.remainder(60);

  final hoursStr = hours.toString().padLeft(2, '0');
  final minutesStr = minutes.toString().padLeft(2, '0');
  final secondsStr = seconds.toString().padLeft(2, '0');

  return '$hoursStr:$minutesStr:$secondsStr';
}