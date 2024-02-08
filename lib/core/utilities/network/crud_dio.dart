import 'package:dio/dio.dart';
import 'package:prepare_project/core/utilities/constant_var/constant.dart';
import 'package:prepare_project/core/utilities/function/set_app_state.dart';
class ApiServices{
  final Dio dio;
  ApiServices({required this.dio});
  // Future<Map<String,dynamic>>postData({required String endPoint, Map<String,dynamic>? data,})async {
  //   final String? token=SetAppState.prefs?.getString('token');
  //   final response=await dio.post('$baseUrl$endPoint',data: data,options: Options(
  //     headers: {
  //     'Content-Type':'application/json',
  //     'Authorization':'token $token'},
  //   ),
  //   );
  //     return response.data;
  // }
  // Future<Map<String,dynamic>>postWithUpdatePhoto({required String endPoint,required FormData data,})async {
  //   final String? token=SetAppState.prefs?.getString('token');
  //     final response=await dio.post('$baseUrl$endPoint',data: data,options: Options(
  //       headers: {
  //       'Authorization':'token $token',
  //       'Content-Type':'multipart/form-data'
  //     },
  //        ),
  //     );
  //     return response.data;
  // }
  // Future<Map<String,dynamic>>getData({required String endPoint,Map<String,dynamic>?data })async {
  //   final String? token=SetAppState.prefs?.getString('token');
  //   var response=await dio.get('$baseUrl$endPoint',data: data,options: Options(headers: {'Authorization':'token $token'}));
  //   return response.data;
  // }
  //
  // /// put request
  //
  // ///patch request
  // Future<Map<String,dynamic>>patchRequestBehindToken({required String endPoint,required Map<String,dynamic> data})async {
  //   final String? token=SetAppState.prefs?.getString('token');
  //   var response=await dio.patch('$baseUrl$endPoint$token',data: data,options: Options(headers: {'Authorization':'token $token',}));
  //   return response.data;
  // }
  // Future<Map<String,dynamic>>patchRequest({required String endPoint,required Map<String,dynamic> data})async {
  //   final String? token=SetAppState.prefs?.getString('token');
  //   var response=await dio.patch('$baseUrl$endPoint',data: data,options: Options(headers: {'Authorization':'token $token',}));
  //   return response.data;
  // }
  //
  // /// delete request
  // Future<Map<String,dynamic>>deleteRequest({required String endPoint,})async {
  //   final String? token=SetAppState.prefs?.getString('token');
  //   var response=await dio.delete('$baseUrl$endPoint',options: Options(headers: {'Authorization':'token $token',}));
  //   return response.data;
  // }
  //
  //
  // /// api request related to tourGuide
  //
  //
  // /// post request
  // Future<Map<String,dynamic>>postTourGuideData({required String endPoint, Map<String,dynamic>? data,})async {
  //   final String? tokenId=SetAppState.prefs?.getString('token');
  //   final response=await dio.post('$tourGuideBaseUrl$endPoint',data: data,options: Options(
  //     headers: {
  //       'Content-Type':'application/json',
  //       'Authorization':'token $tokenId'
  //     },
  //   ),
  //
  //   );
  //   return response.data;
  // }
  //
  // Future<Map<String,dynamic>>postTourGuideWithUpdatePhoto({required String endPoint,required FormData data,})async {
  //   final String? tokenId=SetAppState.prefs?.getString('token');
  //   final response=await dio.post('$tourGuideBaseUrl$endPoint',data: data,options: Options(
  //     headers: {
  //       'Authorization':'token $tokenId',
  //       'Content-Type':'multipart/form-data'
  //     },
  //   ),
  //   );
  //   return response.data;
  // }
  // Future<Map<String,dynamic>>patchWithUpdatePhoto({required String endPoint,required FormData data,})async {
  //   final String? tokenId=SetAppState.prefs?.getString('token');
  //   final response=await dio.patch('$baseUrl$endPoint',data: data,options: Options(
  //     headers: {
  //       'Authorization':'token $tokenId',
  //       'Content-Type':'multipart/form-data'
  //     },
  //   ),
  //   );
  //   return response.data;
  // }
  // /// get request
  // Future<Map<String,dynamic>>getTourGuideData({required String endPoint,Map<String,dynamic>?data })async {
  //   final String? tokenId=SetAppState.prefs?.getString('token');
  //
  //   var response=await dio.get('$tourGuideBaseUrl$endPoint',data: data,options: Options(headers: {'Authorization':'token $tokenId'}));
  //
  //   return response.data;
  // }
  //
  // /// put request
  // Future<Map<String,dynamic>>putTourGuideData({required Map<String,dynamic> data,required String endPoint})async {
  //   final String? tokenId=SetAppState.prefs?.getString('token');
  //   var response=await dio.put('$tourGuideBaseUrl$endPoint',data: data,options: Options(headers: {'Authorization':'token $tokenId',},contentType:'multipart/form-data'));
  //   return response.data;
  // }
  //
  // ///patch request
  // Future<Map<String,dynamic>>patchTourGuideRequest({required String endPoint,required Map<String,dynamic> data})async {
  //   final String? tokenId=SetAppState.prefs?.getString('token');
  //   var response=await dio.patch('$tourGuideBaseUrl$endPoint$tokenId',data: data,options: Options(headers: {'Authorization':'token $tokenId',}));
  //   return response.data;
  // }
  //
  //
  // /// delete request
  // Future<Map<String,dynamic>>deleteTourGuideRequest({required String endPoint,})async {
  //   final String? tokenId=SetAppState.prefs?.getString('token');
  //   var response=await dio.delete('$tourGuideBaseUrl$endPoint',options: Options(headers: {'Authorization':'token $tokenId',}));
  //   return response.data;
  // }
  // /// mutual auth request
  // Future<Map<String,dynamic>>authPost({required String endPoint,Map<String,dynamic>?data})async {
  //   final String? tokenId=SetAppState.prefs?.getString('token');
  //   final response=await dio.post('$authUrl$endPoint',data: data,options: Options(
  //     headers: {
  //       'Content-Type':'application/json',
  //       'Authorization':'token $tokenId'
  //     },
  //   ),
  //
  //   );
  //   return response.data;
  // }
  // Future<Map<String,dynamic>>authGet({required String endPoint,Map<String,dynamic>?data})async {
  //   final String? tokenId=SetAppState.prefs?.getString('token');
  //   final response=await dio.get('$authUrl$endPoint',data: data,options: Options(
  //     headers: {
  //       'Content-Type':'application/json',
  //       'Authorization':'token $tokenId'
  //     },),
  //   );
  //   return response.data;
  // }
  // Future<Map<String,dynamic>>authDel({required String endPoint,Map<String,dynamic>?data})async {
  //   final String? tokenId=SetAppState.prefs?.getString('token');
  //   final response=await dio.delete('$authUrl$endPoint',data: data,options: Options(
  //     headers: {
  //       'Content-Type':'application/json',
  //       'Authorization':'token $tokenId'
  //     },
  //   ),);
  //   return response.data;
  // }
  // Future<Map<String,dynamic>>authPatch({required String endPoint,Map<String,dynamic>?data})async {
  //   final String? tokenId=SetAppState.prefs?.getString('token');
  //   final response=await dio.patch('$authUrl$endPoint',data: data,options: Options(
  //     headers: {
  //       'Content-Type':'application/json',
  //       'Authorization':'token $tokenId'
  //     },
  //   ),
  //
  //   );
  //   return response.data;
  // }

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
    var response=await dio.patch('$baseUrl$endPoint$tokenId',data: data,options: Options(headers: {'Authorization':'token $tokenId',}));
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
}
