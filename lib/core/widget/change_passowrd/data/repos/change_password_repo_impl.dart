import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/core/utilities/constant_var/constant.dart';
import 'package:prepare_project/core/utilities/network/crud_dio.dart';
import 'package:prepare_project/core/widget/change_passowrd/data/repos/change_password_repo.dart';

class ChangePasswordRepoImp extends ChangePasswordRepo{
  final ApiServices apiServices;
  ChangePasswordRepoImp({required this.apiServices});
  @override
  Future<Either<Failure, String>> checkOldPassword({required String oldPass}) async{
    try{
      var result=await apiServices.get(endPoint:'${homeEndMutualPoint}settings/confirmOldPassword',data:{'oldPassword':oldPass} );
      String response= result['message'];
      return right(response);
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

  @override
  Future<Either<Failure, String>> updateNewPassword({required Map<String,dynamic>passwords})async {
    try{
      var result=await apiServices.patch(endPoint:'${homeEndMutualPoint}settings/changeOldPass',data:passwords);

      String response= result['message'];
      return right(response);
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