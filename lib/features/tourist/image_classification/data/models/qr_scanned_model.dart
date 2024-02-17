class QrScannedModel{
  String?rawDate;
  String?imageUrl;
  QrScannedModel({this.imageUrl,this.rawDate});
  factory QrScannedModel.fromJson(Map<String,dynamic>data)=>QrScannedModel(
    rawDate:data['response'],
    imageUrl: data['picture_link'],
  );
  Map<String,dynamic>toJson()=>{'text':rawDate};
}