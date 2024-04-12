class PhotosModel{
  String?photoName;
  PhotosModel({required this.photoName});
  factory PhotosModel.fromJson(Map<String,dynamic>json){
    return PhotosModel(photoName:json['name']);
  }
}