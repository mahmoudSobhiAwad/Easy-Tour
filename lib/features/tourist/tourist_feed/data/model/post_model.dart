import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class PostModel{
  String publisherName;
  String postDate;
  String role;
  String sourceEmail;
  String?postText;
  List<MediaPathWithType>?mediaPosts;
  PostModel({required this.sourceEmail,required this.role,required this.publisherName,required this.postDate,this.postText,this.mediaPosts});
  factory PostModel.fromFireStore(DocumentSnapshot<Map<String, dynamic>> snapshot,SnapshotOptions? options){
    final data = snapshot.data();
    return PostModel(
        sourceEmail: data?['email'],
        role: data?['role'],
        publisherName: data?['publisherName'],
        postDate: DateFormat('d MMM, h:mm ').format(DateTime.parse(data?['dateTime']),),
        mediaPosts:data?['media'] is Iterable ? List<MediaPathWithType>.from(data?['media'].map((x) => MediaPathWithType.fromJson(x))) : null,
        postText: data?['text'],
    );
  }
  Map<String, dynamic> toFireStore() {
    return {
      "publisherName": publisherName,
      "dateTime": postDate.toString(),
      "role": role,
      'email':sourceEmail,
      if (postText != null) "text": postText,
      if (mediaPosts != null) "media": List.generate(mediaPosts!.length, (index) =>MediaPathWithType(type: mediaPosts![index].type, path: mediaPosts![index].path).toJson()),
    };
  }

}

class MediaPathWithType{
  MediaType type;
  String path;
  MediaPathWithType({required this.path,required this.type});
  factory MediaPathWithType.fromJson(Map<String,dynamic>json){
    return MediaPathWithType(type: MediaTypeExtenstion.fromString(json['type']), path: json['path']);
  }
  Map<String,dynamic>toJson(){
    return {
      "type":type.name,
      "path":path,
    };
  }

}
enum MediaType {video,image}
extension MediaTypeExtenstion on MediaType {
  static MediaType fromString(String colorString) {
    return MediaType.values.firstWhere(
          (e) => e.toString().split('.').last == colorString,
      orElse: () => throw ArgumentError('$colorString is not a valid value'),
    );
  }
}