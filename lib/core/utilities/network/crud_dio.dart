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
    if(response.statusCode==204){
      return {'message':'sent'};
    }
    return response.data;
  }
  Future<Map<String,dynamic>>dynamicPost({required String endPoint, dynamic data,})async {
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
    var response=await dio.put('$baseUrl$endPoint',data: data,options: Options(headers: {'Authorization':'token $token',}));
    if(response.statusCode==204){
      return {'message':'success'};
    }
    return response.data;
  }
  /// get request
  Future<Map<String,dynamic>>get({required String endPoint,Map<String,dynamic>?data,Map<String,dynamic>?queryParam,String?chatID})async {
    final String? tokenId=SetAppState.prefs?.getString('token');
    var response=await dio.get('$baseUrl$endPoint',data: data,queryParameters: queryParam,options: Options(headers: {
      'Authorization':'token $tokenId',
      'chatid':chatID,
    }));
    if(response.statusCode==204){
      return {};
    }
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
    if(response.statusCode==204){
      return {'message':'request Accepted'};
    }
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

  /// google-map API
  Future<Map<String,dynamic>>postGoogleNewApi({required dynamic data,required String endPoint,required String fieldMask})async{
    final response=await dio.post('$googleNewApiUrl$endPoint',data:data,options: Options(
      headers: {
        'X-Goog-Api-Key':androidApiGoogleMapKey,
        'Content-Type':'application/json',
        'X-Goog-FieldMask':fieldMask,
      }
    ) );
    return response.data;
  }
  Future<Map<String,dynamic>>postGoogleRouteApi({required dynamic data,})async{
    final response=await dio.post(routeApiUrl,data:data,options: Options(
      headers: {
        'X-Goog-Api-Key':androidApiGoogleMapKey,
        'Content-Type':'application/json',
        'X-Goog-FieldMask':fieldMaskForGetRoute,
      }
    ) );
    return response.data;
  }
  Future<Map<String,dynamic>>getPlacePhoto({required String data})async{
    final response=await dio.get('https://places.googleapis.com/v1/$data/media?key=$androidApiGoogleMapKey&maxHeightPx=${500}&skipHttpRedirect=${true}');
    return response.data;
  }
  Future<Map<String,dynamic>>normalGet(String endPoint,{Map<String,dynamic>?data})async{
    final response=await dio.get(endPoint,data:data,options: Options(headers: {

    }));
    return response.data;
  }
  Future<dynamic>normalPost(String endPoint,{Map<String,dynamic>?data})async{
    final response=await dio.post(endPoint);
    return response.data;
  }

}
