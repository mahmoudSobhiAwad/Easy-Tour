class ReviewModel{
String?name;
num?rating;
String?reviewText;
ReviewerInfo?reviewerInfo;
ReviewModel({
  this.rating,
  this.reviewText,
  this.name,
  this.reviewerInfo,
});
factory ReviewModel.fromJson(Map<String,dynamic>json){
  return ReviewModel(
    rating: json['rating']??0,
    name: json['name']??"UnKnown",
    reviewText: json['text']['text']??"No Date",
    reviewerInfo: ReviewerInfo.fromJson(json['authorAttribution']),
  );
}
}
class ReviewerInfo{
  String?name;
  String?photoUrl;
  String?publishTime;
  ReviewerInfo({
    this.name,
    this.photoUrl,
    this.publishTime,
  });

  factory ReviewerInfo.fromJson(Map<String,dynamic>json){
    return ReviewerInfo(
      name: json['displayName'],
      publishTime: json['publishTime'],
      photoUrl: json['photoUri'],
    );
  }
}