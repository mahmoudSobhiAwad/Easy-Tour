class IatCodeModel{
  String cityName;
  String countryName;
  String airportCode;
  IatCodeModel({required this.cityName,required this.airportCode,required this.countryName});
  factory IatCodeModel.fromJson(Map<String,dynamic>json){
    return IatCodeModel(cityName: json['cityName'], airportCode: json['airportCode'], countryName: json['countryName']);
  }
}