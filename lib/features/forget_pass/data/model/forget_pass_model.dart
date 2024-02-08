class ResetPassModel{
  final String?token;
  final String?resetCode;
  final String?message;
  ResetPassModel({this.resetCode,this.token,this.message});
  factory ResetPassModel.fromJson(Map<String,dynamic>json)=>ResetPassModel(
    resetCode: json['resetCode'],//resetCode
    token:json['token'], );
  factory ResetPassModel.successMessage(Map<String,dynamic>json)=>ResetPassModel(
    message: json['message'],//resetCode
  );
}