import 'package:country_picker/country_picker.dart';

class CreateFlightModel{
  String tripId;
  List<TravelersData>travelersDate;
  CreateFlightModel({required this.tripId,required this.travelersDate});
  factory CreateFlightModel.fromJson(Map<String,dynamic>json){
    return CreateFlightModel(tripId: json['id'], travelersDate: []);
  }
  List<Map<String,dynamic>> toJson(){
    return
      [
        ...List.generate(travelersDate.length, (index) => travelersDate[index].toJson(index)),
      ];
  }
}

class TravelersData{
  String? birthDate;
  String? fName;
  String? lName;
  String? gender;
  String? email;
  String? phoneNum;
  String? docType;
  String? docBirthPlace;
  String? docExpiryDate;
  String? docNumber;
  String? issuanceDate;
  Country? nationality;
  TravelersData({this.email,this.phoneNum,this.birthDate,this.docBirthPlace,this.docExpiryDate,this.docNumber,this.docType,this.fName,this.gender,this.issuanceDate,this.lName,this.nationality});
  Map<String,dynamic>toJson(int index){
    return {
      "id": "${index+1}",
      "dateOfBirth": "$birthDate",
      "name": {
        "firstName": "$fName",
        "lastName": "$lName"
      },
      "gender": "$gender",
      "contact": {
        "emailAddress": "$email",
        "phones": [
          {
            "deviceType": "MOBILE",
            "countryCallingCode": "20",
            "number": "$phoneNum"
          }
        ]
      },
      "documents": [
        {
          "documentType": "$docType",
          "birthPlace": "$docBirthPlace",
          "issuanceLocation": "$docBirthPlace",
          "issuanceDate": "$issuanceDate",
          "number": "$docNumber",
          "expiryDate": "$docExpiryDate",
          "issuanceCountry": "${nationality?.countryCode}",
          "validityCountry": "${nationality?.countryCode}",
          "nationality": "${nationality?.countryCode}",
          "holder": true
        }
      ]
    };
  }
  
}


      var data={
        "id": "1",
        "dateOfBirth": "1982-01-16",
        "name": {
          "firstName": "Ali",
          "lastName": "Ssddsi"
        },
        "gender": "MALE",
         "contact": {
          "emailAddress": "dsdsds@gmail.com",
          "phones": [
            {
              "deviceType": "MOBILE",
              "countryCallingCode": "20",
              "number": "78787854"
            }
          ]
        },
        "documents": [
          {
            "documentType": "PASSPORT",
            "birthPlace": "Cairo",
            "issuanceLocation": "Cairo",
            "issuanceDate": "2016-04-14",
            "number": "11221122",
            "expiryDate": "2025-12-14",
            "issuanceCountry": "EG",
            "validityCountry": "EG",
            "nationality": "EG",
            "holder": true
          }
        ]
      };