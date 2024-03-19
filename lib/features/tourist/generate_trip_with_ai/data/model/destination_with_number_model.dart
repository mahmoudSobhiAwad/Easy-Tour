class DestinationPlaceDayModel{
  String?placeName;
  String?startDate;
  String?lastDate;
  int?numOfDay;
  DestinationPlaceDayModel({this.placeName,this.numOfDay});
  Map<String,dynamic>toJson(){
    return {
      'placeName':placeName,
      'numOfDay':numOfDay,
    };
  }
}