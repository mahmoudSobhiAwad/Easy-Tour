import 'package:dio/dio.dart';
import 'package:prepare_project/core/utilities/network/api_consumer.dart';

class DioConsumer implements ApiConsumer{
  final Dio client;
  DioConsumer({required this.client}) ;
  ///to overcome bad certificate error we have to do that code
  @override
  Future<dynamic>get(String? url, {Map<String, dynamic>? queryParameter, Map<String, dynamic>? headers})async {
    final response=await client.get(
      url!,
      queryParameters: queryParameter,
    );
    return response.data['user'];
  }
  @override
  Future<dynamic> post(String? url, {Map<String, dynamic>? body, bool isFormDataEnabled = false, Map<String, dynamic>? queryParameter, Map<String, dynamic>? headers}) {
    // TODO: implement post
    throw UnimplementedError();
  }
  @override
  Future<dynamic> patch(String? url, {Map<String, dynamic>? body, Map<String, dynamic>? queryParameter, Map<String, dynamic>? headers}) {
    // TODO: implement patch
    throw UnimplementedError();
  }
  @override
  Future<dynamic> delete(String? url, {Map<String, dynamic>? body, Map<String, dynamic>? queryParameter, Map<String, dynamic>? headers}) {
    // TODO: implement delete
    throw UnimplementedError();
  }
  @override
  Future<dynamic> put(String? url, {Map<String, dynamic>? body, Map<String, dynamic>? queryParameter, Map<String, dynamic>? headers}) {
    // TODO: implement put
    throw UnimplementedError();
  }

}