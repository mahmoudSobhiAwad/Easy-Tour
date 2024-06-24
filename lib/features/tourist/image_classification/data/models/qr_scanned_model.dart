class QrScannedModel{
  String?rawDate;
  ImagePathWithType?imageUrl;
  QrScannedModel({this.imageUrl,this.rawDate});
  factory QrScannedModel.fromJson(Map<String,dynamic>data)=>QrScannedModel(
    rawDate:data['response'],
    imageUrl: ImagePathWithType(type: imageType.network,image:data['picture_link']),
  );
  Map<String,dynamic>toJson()=>{'text':rawDate};
}
class ImagePathWithType{
  String?image;
  imageType type;
  ImagePathWithType({required this.type,this.image});
}
enum imageType {local,network}