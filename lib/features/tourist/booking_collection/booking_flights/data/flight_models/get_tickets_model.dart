class GetTicketsModel{
  String? lastTicketTime;
  bool instantBooking;
  int? avaSeats;
  num? price;
  Itineraries? goingItinerariesList;
  Itineraries?returnItinerariesList;
  OriginDestinations?goingTrip;
  List<String>?travelersTypes;
  String cabinType;
  GetTicketsModel({this.price,this.instantBooking=false,this.avaSeats,this.lastTicketTime,this.goingItinerariesList,this.returnItinerariesList,this.goingTrip,this.travelersTypes,this.cabinType='BUSINESS'});

  factory GetTicketsModel.fromJson(Map<String,dynamic>json){
    return GetTicketsModel(
      price: json['price']['grandTotal'],
      lastTicketTime: json['lastTicketingDate'],
      instantBooking: json['instantTicketingRequired'],
      goingItinerariesList: Itineraries.fromJson(json['itineraries'][0],),
      returnItinerariesList:Itineraries.fromJson(json['itineraries'][1],),
    );
  }
  Map<String,dynamic>toJson(){
    return {
      "originDestinations":[
        {
          "id": "1",
          "originLocationCode": "${goingTrip?.originIatCode}",
          "destinationLocationCode": "${goingTrip?.departureIatCode}",
          "departureDateTimeRange": {
            "date": "${goingTrip?.departureLeaveTime}"
          }
        },
        goingTrip?.departureReturnTime==null?null:{
          "id": "2",
          "originLocationCode": "${goingTrip?.departureIatCode}",
          "destinationLocationCode": "${goingTrip?.originIatCode}",
          "departureDateTimeRange": {
            "date": "${goingTrip?.departureReturnTime}"
          }
        },
      ],
      "travelers": [...List.generate(travelersTypes?.length??0, (index) => {
        'id':'${index+1}',
        'travelerType':travelersTypes?[index],
      }),],
      "sources": [
        "GDS"
      ],
      "searchCriteria": {
        "maxFlightOffers": 5,
        "flightFilters": {
          "cabinRestrictions": [
            {
              "cabin": cabinType,
              "originDestinationIds": [
                "1"
              ]
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
        duration: json['duration'],
        segments: segmentsList);
  }
}
class Segments{
  DepartureOrLeaveOfSegments departureSeg;
  DepartureOrLeaveOfSegments arrivalSeg;
  Segments({required this.arrivalSeg,required this.departureSeg});
  
  factory Segments.fromJson(Map<String,dynamic>json){
    return Segments(arrivalSeg: DepartureOrLeaveOfSegments.fromJson(json['arrival']), departureSeg: DepartureOrLeaveOfSegments.fromJson(json['departure']));
  }
  
}

class DepartureOrLeaveOfSegments{
  String iatCode;
  String timeToLeave;
  DepartureOrLeaveOfSegments({required this.iatCode,required this.timeToLeave});
  factory DepartureOrLeaveOfSegments.fromJson(Map<String,dynamic>json){
    return DepartureOrLeaveOfSegments(iatCode: json['iataCode'], timeToLeave: json['at']);
  }
}
class OriginDestinations{
  String ? originIatCode;
  String ? departureIatCode;
  String ? departureLeaveTime;
  String ? departureReturnTime;
  OriginDestinations({required this.departureIatCode,required this.departureLeaveTime,required this.originIatCode,this.departureReturnTime});
}