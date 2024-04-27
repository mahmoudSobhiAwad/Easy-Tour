import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/core/utilities/constant_var/constant.dart';
import 'package:prepare_project/core/utilities/network/crud_dio.dart';
import 'package:prepare_project/features/tourist/settings/data/repo/setting_repo.dart';

class SettingRepoImp implements SettingRepo {
  final ApiServices apiServices;
  SettingRepoImp({required this.apiServices});

  @override
  Future<Either<Failure, String>> sendFcmDevice(Map<String, dynamic> params)async {
    try {
      var response = await apiServices.putData(
          data: params, endPoint:'${homeCommon}notifications/storePushToken');
      return right(response['message']);
    }
    catch(e){
      if(e is DioException){
        return left(ServerFailure.fromDioError(e));
      }
      else{
        return left(ServerFailure(e.toString()));
      }
    }

  }

}