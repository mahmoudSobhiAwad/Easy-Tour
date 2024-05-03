import 'package:shared_preferences/shared_preferences.dart';
class SetAppState{

  static SharedPreferences? prefs;
  static Future<void>setShared()async{
    prefs=await SharedPreferences.getInstance();
  }
  static Future<void> setCurrIndex(int?index)async{
    await prefs?.setInt('currIndex', index??0);
  }
  static Future<void> setToken({required String? token})async{
    await prefs?.setString('token',token??'');
  }
  static Future<void> setFcmToken({required String? token})async{
    await prefs?.setString('fcmToken',token??'');
  }
  static Future<void> setName({required String? name})async{
    await prefs?.setString('name',name??'');
  }
  static Future<void> setEmail({required String? email})async{
    await prefs?.setString('email',email??'');
  }
  static Future<void> setProfilePic({required String? profileUrl})async{
    await prefs?.setString('profileUrl',profileUrl??"");
  }
  static Future<void> setRole({required String? role})async{
    await prefs?.setString('role',role??"");
  }
  static Future<void> chatBotCurrentPage(int? index)async{
    await prefs?.setInt('pageIndex',index??0);
  }
  static Future<void> generateTripCurrentPage(int? index)async{
    await prefs?.setInt('tripIndex',index??0);
  }

}