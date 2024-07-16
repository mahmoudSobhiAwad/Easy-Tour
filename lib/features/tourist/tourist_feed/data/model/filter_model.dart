class FilterPostModel{
  List<String>?imageLinks;
  List<String>?videoLinks;
  String?text;
  List<int>?imgResult;
  List<int>?textResult;
  List<int>?videoResult;
  FilterPostModel({this.text,this.imageLinks,this.videoLinks,this.imgResult,this.textResult,this.videoResult});
  factory FilterPostModel.fromJson(Map<String,dynamic>json){
    return FilterPostModel(
      imgResult: List<int>.from(json['img_result'],),
      videoResult: List<int>.from(json['videos_result']),
      textResult: List<int>.from(json['post_result']),
    );
  }
  Map<String,dynamic>toJson(){
    return {
     if(videoLinks!=null) "videos_links":List.generate(videoLinks!.length, (index) => videoLinks![index]),
     if(imageLinks!=null) "image_links":List.generate(imageLinks!.length, (index) => imageLinks![index]),
     if(text!=null) "post":text,
  };
  }
}