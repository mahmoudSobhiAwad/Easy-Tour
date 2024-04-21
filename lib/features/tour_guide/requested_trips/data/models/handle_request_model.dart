class RequestsTripForTGModel{
  String?tripID;
  String?comment;
  String?requestStatus;
  RequestedByModel?requestedBy;
  RequestedTripModel?requestedTripModel;
  RequestedTripDetailsModel?requestedTripDetailsModel;
  RequestsTripForTGModel({this.requestedTripDetailsModel,this.requestStatus,this.requestedTripModel,this.tripID,this.comment,this.requestedBy});
  factory RequestsTripForTGModel.fromJson(Map<String,dynamic>json){
    return RequestsTripForTGModel(
      tripID: json['_id'],
      requestStatus: json['requestStatus'],
      requestedBy: RequestedByModel.fromJson(json['requestedBy']),
      requestedTripModel: RequestedTripModel.fromJson(json['requestedTrip']),
      requestedTripDetailsModel: RequestedTripDetailsModel.fromJson(json['requestDetails']),
      comment: json['comment'],
    );
  }
}
class RequestedByModel{
  String?systemEmail;
  String?userName;
  String?image;
  String?email;
  String?countryName;
  String?countryFlag;
  String?phoneNum;
  int?age;
  RequestedByModel({this.countryName,this.age,this.countryFlag,this.email,this.userName,this.image,this.phoneNum,this.systemEmail});
  factory RequestedByModel.fromJson(Map<String,dynamic>json){
    return RequestedByModel(
      systemEmail: json['systemEmail'],
      userName: json['userName'],
      image: json['image'],
      email:json['email'] ,
      countryFlag:json['countryFlag'] ,
      countryName: json['country'],
      phoneNum: json['phoneNumber'],
      age: json['age'],
    );
  }
}
class RequestedTripModel{
  String?id;
  String?image;
  String?title;
  String?brief;
  RequestedTripModel({this.id,this.image,this.title,this.brief});
  factory RequestedTripModel.fromJson(Map<String,dynamic>json){
    return RequestedTripModel(
      id: json['ID'],
      image: json['image'],
      title: json['title'],
      brief: json['brief'],
    );
  }
}
class RequestedTripDetailsModel{
  String?tripType;
  String?startDate;
  int?additionalTravelers;
  RequestedTripDetailsModel({this.tripType,this.startDate,this.additionalTravelers});
  factory RequestedTripDetailsModel.fromJson(Map<String,dynamic>json){
    return RequestedTripDetailsModel(
      tripType: json['tripType'],
      startDate: json['startDate'],
      additionalTravelers: json['additionalTravelersNo'],
    );
  }
}
