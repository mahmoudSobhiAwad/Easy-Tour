import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class PostModel{
  String publisherName;
  String postDate;
  String role;
  String sourceEmail;
  String?postText;
  List<String>?postImages;
  PostModel({required this.sourceEmail,required this.role,required this.publisherName,required this.postDate,this.postText,this.postImages});
  factory PostModel.fromFireStore(DocumentSnapshot<Map<String, dynamic>> snapshot,SnapshotOptions? options){
    final data = snapshot.data();
    return PostModel(
        sourceEmail: data?['email'],
        role: data?['role'],
        publisherName: data?['publisherName'],
        postDate: DateFormat('d MMM, h:mm ').format(DateTime.parse(data?['dateTime']),),
        postImages:data?['images'] is Iterable ? List.from(data?['images']) : null,
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
      if (postImages != null) "images": postImages,
    };
  }
}