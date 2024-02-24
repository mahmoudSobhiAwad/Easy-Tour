import 'package:dio/dio.dart';
import 'package:prepare_project/core/utilities/constant_var/constant.dart';
import 'package:prepare_project/core/utilities/function/set_app_state.dart';
class ApiServices{
  final Dio dio;
  ApiServices({required this.dio});
  /// post request
  Future<Map<String,dynamic>>post({required String endPoint, Map<String,dynamic>? data,})async {
    final String? tokenId=SetAppState.prefs?.getString('token');
    final response=await dio.post('$baseUrl$endPoint',data: data,options: Options(
      headers: {
        'Content-Type':'application/json',
        'Authorization':'token $tokenId'
      },
    ),

    );
    return response.data;
  }

  Future<Map<String,dynamic>>postWithPhoto({required String endPoint,required FormData data,})async {
    final String? tokenId=SetAppState.prefs?.getString('token');
    final response=await dio.post('$baseUrl$endPoint',data: data,options: Options(
      headers: {
        'Authorization':'token $tokenId',
        'Content-Type':'multipart/form-data'
      },
    ),
    );
    return response.data;
  }
  ///put request
  Future<Map<String,dynamic>>putData({required Map<String,dynamic> data,required String endPoint})async {
    final String? token=SetAppState.prefs?.getString('token');
    var response=await dio.put('$baseUrl$endPoint',data: data,options: Options(headers: {'Authorization':'token $token',},contentType:'multipart/form-data'));
    return response.data;
  }
  /// get request
  Future<Map<String,dynamic>>get({required String endPoint,Map<String,dynamic>?data})async {
    final String? tokenId=SetAppState.prefs?.getString('token');
    var response=await dio.get('$baseUrl$endPoint',data: data,options: Options(headers: {'Authorization':'token $tokenId'}));

    return response.data;
  }
  /// patch with photo
  Future<Map<String,dynamic>>patchWithPhoto({required String endPoint,required FormData data,})async {
    final String? tokenId=SetAppState.prefs?.getString('token');
    final response=await dio.patch('$baseUrl$endPoint',data: data,options: Options(
      headers: {
        'Authorization':'token $tokenId',
        'Content-Type':'multipart/form-data'
      },
    ),
    );
    return response.data;
  }
  ///patch request
  Future<Map<String,dynamic>>patch({required String endPoint,required Map<String,dynamic> data})async {
    final String? tokenId=SetAppState.prefs?.getString('token');
    var response=await dio.patch('$baseUrl$endPoint',data: data,options: Options(headers: {'Authorization':'token $tokenId',}));
    return response.data;
  }
  /// patch With token behind used for forget reset password almost
  Future<Map<String,dynamic>>patchBehindToken({required String endPoint,required Map<String,dynamic> data})async {
    final String? tokenId=SetAppState.prefs?.getString('token');
    var response=await dio.patch('$baseUrl$endPoint$tokenId',data: data,options: Options(
        //headers: {'Authorization':'token $tokenId',}
        ));
    return response.data;
  }

  /// delete request
  Future<Map<String,dynamic>>delete({required String endPoint,Map<String,dynamic>?data})async {
    final String? tokenId=SetAppState.prefs?.getString('token');

    var response=await dio.delete('$baseUrl$endPoint',data: data,options: Options(headers: {'Authorization':'token $tokenId',}));
    return response.data;
  }

  ///chat-bot request
  Future<Map<String,dynamic>>askQuestionWithChatBot({Map<String,dynamic>? data})async {
    final response=await dio.post(chatBotUrl,data: data,options: Options(
      headers: {
        'Content-Type':'application/json',
      },
    ),

    );
    return response.data;
  }
  Future<Map<String,dynamic>>requestGenerateTrip({String? data})async {
    final response=await dio.post(generateTripUrl,data: data,options: Options(
      headers: {
        'Content-Type':'application/json',
      },
    ),

    );
    return response.data;
  }


  Future<Map<String,dynamic>>sendQrCode({required dynamic data})async {
    final response=await dio.post(scanQrUrl,data: data,options: Options(
      headers: {
        'Content-Type':'application/json',
      },
    ),

    );
    return response.data;
  }
}
