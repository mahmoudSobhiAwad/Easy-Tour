import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/core/utilities/constant_var/constant.dart';
import 'package:prepare_project/core/utilities/network/crud_dio.dart';
import 'package:prepare_project/core/widget/delete_account/data/repos/delete_acc_repo.dart';

class DeleteAccountRepoImpl implements DeleteAccRepo {
  final ApiServices apiServices;
  DeleteAccountRepoImpl({required this.apiServices});
  @override
  Future<Either<Failure, String>> deleteAccount() async{
    try{
      var result= await apiServices.delete(endPoint: '${homeEndPoint}settings/deleteUser',);
      String response=result['message'];
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
  Future<Either<Failure, String>> checkOldPassword({required String oldPass}) async{
    try{
      var result=await apiServices.get(endPoint: 'confirmOldPassword',data:{'oldPassword':oldPass} );
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