import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/core/utilities/constant_var/constant.dart';
import 'package:prepare_project/core/utilities/network/crud_dio.dart';
import 'package:prepare_project/features/forget_pass/data/model/forget_pass_model.dart';
import 'package:prepare_project/features/forget_pass/data/repo/forget_pass_repo.dart';

class ForgetPassRepoImpl extends ForgetPassRepo{
  final ApiServices apiServices;
  ForgetPassRepoImpl({required this.apiServices});
  @override
  Future<Either<Failure, ResetPassModel>> sendEmailForgetTouristPassword(Map<String, dynamic> data) async{
    try{
      var result=await apiServices.patch(endPoint: '${authTourist}forgetPassword', data: data);
      ResetPassModel model=ResetPassModel.fromJson(result);
      return right(model);
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
  Future<Either<Failure, ResetPassModel>> resetTouristPassword(Map<String, dynamic> data) async{
    try{
      var result= await apiServices.patchBehindToken(endPoint: '${authTourist}resetPassword', data: data);
      ResetPassModel model=ResetPassModel.successMessage(result);
      return right(model);
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
  Future<Either<Failure, ResetPassModel>>sendEmailForgetTourGuidePassword(Map<String, dynamic> data) async{
    try{
      var result=await apiServices.patch(endPoint: '${authTourGuide}forgetPassword', data: data);
      ResetPassModel model=ResetPassModel.fromJson(result);
      return right(model);
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
  Future<Either<Failure, ResetPassModel>> resetTourGuidePassword(Map<String, dynamic> data) async{
    try{
      var result= await apiServices.patchBehindToken(endPoint: '${authTourGuide}resetPassword', data: data);
      ResetPassModel model=ResetPassModel.successMessage(result);
      return right(model);
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