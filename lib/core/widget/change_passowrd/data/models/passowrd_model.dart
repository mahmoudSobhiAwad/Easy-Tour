class ChangePasswordModel{
  String newPass;
  String confirmNewPas;
  ChangePasswordModel({required this.confirmNewPas,required this.newPass});
 Map<String,dynamic>toJson()=>{
   'newPassword':newPass,
   'confirmNewPassword':confirmNewPas,
 };
}