import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:prepare_project/core/utilities/function/set_app_state.dart';
class CustomInterceptors extends Interceptor {
  String? tokenId=SetAppState.prefs?.getString('token');
  final Dio client;
  CustomInterceptors({required this.client});
  /// that done
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers[HttpHeaders.acceptHeader]=ContentType.json;
    if(tokenId!=''){
      options.headers.addAll({'Authorization':'token $tokenId',});
    }
    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');
    super.onRequest(options, handler);
  }
///that done
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    debugPrint('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    if(err.response?.statusCode==401){
      await refreshToken();
    }
    try{
      handler.resolve(await _retry(err.requestOptions));
    }
    on DioException catch(e){
      handler.next(e);
    }

    super.onError(err, handler);
  }
  Future<Response> refreshToken() async {
    var response = await client.post('',
        options: Options(
            headers: {"Refresh-Token": "refresh-token" }));
    // on success response, deserialize the response
    if (response.statusCode == 200) {
      // LoginRequestResponse requestResponse =
      //    LoginRequestResponse.fromJson(response.data);
      // UPDATE the STORAGE with new access and refresh-tokens
      return response;
    }
    return response;

  }
  /// i think that works
  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: {
        "Authorization": "token $tokenId",
      },
    );

    // Retry the request with the new `RequestOptions` object.
    return client.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }
}