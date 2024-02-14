import 'package:dio/dio.dart';
import 'package:prepare_project/core/utilities/function/set_app_state.dart';

abstract class Failure {
  final String? errMessage;
  final int?statusCode;
  const Failure(this.errMessage,{this.statusCode});

}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage,{super.statusCode});

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioException.connectionTimeout:
        return ServerFailure('Connection timeout with ApiServer',);

      case DioException.sendTimeout:
        return ServerFailure('Send timeout with ApiServer');

      case DioException.receiveTimeout:
        return ServerFailure('Receive timeout with ApiServer',);

      case DioException.badResponse:
        return ServerFailure.fromResponse(
            dioError.response?.statusCode,
            dioError.response?.data);
      case DioException.requestCancelled:
        return ServerFailure('Request to ApiServer was cancelled');
        default:
          return ServerFailure.fromResponse(dioError.response?.statusCode, dioError.response?.data);
    }
  }

  factory ServerFailure.fromResponse(int? statusCode,Map<String,dynamic> data)  {

    if (statusCode == 400 || statusCode == 403) {
      return ServerFailure(data['message']??"Error due to Server",statusCode: 400);
    }
   else if(statusCode ==401){

     SetAppState.setToken(token: data['newToken']).then((value){});
     return ServerFailure('error due to refresh token',statusCode: 401);
    }
    else if (statusCode == 404) {
      return ServerFailure('Your request not found, Please try later!',statusCode: 404);
    } else if (statusCode == 500)
    {
      return ServerFailure('${data['message']}Internal Server error, Please try later',statusCode: 500);

    } else {
      return ServerFailure("Server may be not exist at that moment");
    }
  }
}