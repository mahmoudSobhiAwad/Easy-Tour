class RequestTripModel{
  String?tripID;
  String?userName;
  String?startTripDate;
  String?email;
  String?country;
  String?countryFlag;
  String?phoneNumber;
  String?tripType;
  String?travelerNum;
  String?age;
  String?comment;
  RequestTripModel({required this.tripID,this.email,this.phoneNumber,this.age,this.comment,this.country,this.countryFlag,this.startTripDate,this.travelerNum,this.userName,this.tripType});
  Map<String,dynamic>toJson(){
    return {
      "tripID": tripID,
      "userName":userName,
      "startTripDate":startTripDate,
      "email":email,
      "country":country,
      "countryFlag":countryFlag,
      "phoneNumber":phoneNumber,
      "tripType":tripType,
      "travelers":travelerNum,
      "age":age,
      "comment":comment,
    };
  }
}
