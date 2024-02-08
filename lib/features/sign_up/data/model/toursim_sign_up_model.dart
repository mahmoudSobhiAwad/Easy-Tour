class TourismSignUpModel
{
  final String?email;
  final String?password;
  final String?confirmPassword;
  final String?name;
  final String?token;

  TourismSignUpModel({this.email,this.password,this.name,this.confirmPassword,this.token});
  Map<String,dynamic>toJson()=>{
    'email':email,
    'password':password,
    'confirmPassword':confirmPassword,
    'userName':name,
  };
}
