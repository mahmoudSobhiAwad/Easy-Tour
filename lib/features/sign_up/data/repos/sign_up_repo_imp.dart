import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:prepare_project/core/utilities/constant_var/constant.dart';
import 'package:prepare_project/core/utilities/network/crud_dio.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/features/sign_up/data/repos/sign_up_repo.dart';
import '../model/toursim_sign_up_model.dart';
class SignUpRepoImp implements SignUpRepo {
  final ApiServices apiServices;
  SignUpRepoImp(this.apiServices,);
  @override
  Future<Either<Failure,String>> signUpAsTourist(TourismSignUpModel model) async{
    try{
      var data=await apiServices.post(endPoint: '${authTourist}signUp', data:model.toJson());
      String touristModel=data['message'];
      return right(touristModel);
    }
    catch(e){
      if(e is DioException){
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> signUpAsTourGuide(FormData model) async{
    try{
      var data=await apiServices.postWithPhoto(endPoint:'${authTourGuide}signUp', data:model);
      String tourGuideModel=data['message'];
      return right(tourGuideModel);
    }
    catch(e){
      if(e is DioException){
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}