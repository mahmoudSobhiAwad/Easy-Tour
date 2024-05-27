class FacilityModel{
  int facilityCode;
  int facilityGroupCode;
  String? description;
  FacilityModel({required this.facilityCode,required this.facilityGroupCode,this.description});
  factory FacilityModel.fromJson(Map<String,dynamic>json){
    return FacilityModel(
        facilityCode: json['facilityCode'],
        facilityGroupCode: json['facilityGroupCode'],
    );
  }
}