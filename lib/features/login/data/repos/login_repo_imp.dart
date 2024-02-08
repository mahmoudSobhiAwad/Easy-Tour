import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:prepare_project/core/utilities/constant_var/constant.dart';
import 'package:prepare_project/core/utilities/network/crud_dio.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/features/login/data/repos/log_in_repo.dart';
import 'package:prepare_project/features/sign_up/data/model/tour_guide_model.dart';
import '../model/toursim_sign_in_model.dart';
class LoginRepoImpl implements LoginRepo{
  final ApiServices apiServices;
  LoginRepoImpl(this.apiServices);
  ///tourist
  @override
  Future<Either<Failure,TourismSignInModel>> loginAsTourism(Map<String,dynamic> loginData) async{
    try{
      var data=await apiServices.post(endPoint: '${authTourist}login', data: loginData);
      TourismSignInModel touristModel= TourismSignInModel.getInfoFromJson(data['user']);
      return right(touristModel);
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
  Future<Either<Failure, TourGuideSignUpModel>> loginAsTourGuide(Map<String, dynamic> data) async{
    try{
      var response=await apiServices.post(endPoint: '${authTourGuide}login', data: data);
      TourGuideSignUpModel tourGuideSignUpModel= TourGuideSignUpModel.fromJson(response['user']);
      return right(tourGuideSignUpModel);
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