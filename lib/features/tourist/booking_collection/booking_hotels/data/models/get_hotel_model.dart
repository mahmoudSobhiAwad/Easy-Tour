import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/models/destinations_model.dart';

class HotelsModel{
  int? code;
  String? name;
  String?describe;
  int?categoryCode;
  String?accommodationType;
  List<SegmentModel>?segment;
  String?address;
  String?cityName;
  List<PhoneModel>?phoneList;
  String?webUrl;
  List<ImagesPathModel>?imagesList;
  HotelsModel({required this.name,required this.code,this.address,this.accommodationType,this.categoryCode,this.cityName,this.describe,this.imagesList,this.phoneList,this.segment,this.webUrl});
  factory HotelsModel.fromJson(Map<String,dynamic>json){
    return HotelsModel(
      name: json['name']['content'],
      code: json['code'],
      describe: json['description']['content'],
      categoryCode: getHotelRate(json['categoryCode']),
      accommodationType: json['accommodationTypeCode'],
      segment:getSegmentList(json['segmentCodes']??[],),
      address: json['address']['content'],
      imagesList:json['images']!=null?(json['images']as List).map((imagePath) => ImagesPathModel.fromJson(imagePath)).toList():null,
      phoneList:json['phones']!=null?(json['phones'] as  List).map((phoneModel) => PhoneModel.fromJson(phoneModel)).toList():null,
      webUrl:json['web'] ,
      cityName:json['city']['content'] ,
    );
  }
}
List<SegmentModel>getSegmentList(List<dynamic>segment){
  if(segment.isNotEmpty){
    List<SegmentModel>resultedSegment=[];
    for(var item in segment){
      resultedSegment=segmentList.where((element) => element.code==item).toList();
    }
  return resultedSegment;}
  return [];
}
class PhoneModel{
  String? phoneNum;
  String? phoneType;
  PhoneModel({this.phoneNum,this.phoneType});
  factory PhoneModel.fromJson(Map<String,dynamic>json){
    return PhoneModel(
      phoneNum: json['phoneNumber'],
      phoneType: json['phoneType'],
    );
  }
}
class ImagesPathModel{
  String?imagePath;
  ImagesPathModel({this.imagePath});
  factory ImagesPathModel.fromJson(Map<String,dynamic>json){
    return ImagesPathModel(
      imagePath: json['path'],
    );
  }
}
int getHotelRate(String code){
  int index=categoryList.indexWhere((element) => element.code==code);
  return categoryList[index].simpleCode??3;
}
