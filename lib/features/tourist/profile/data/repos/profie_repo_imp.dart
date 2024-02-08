import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/core/utilities/constant_var/constant.dart';
import 'package:prepare_project/core/utilities/network/crud_dio.dart';
import 'package:prepare_project/features/tourist/profile/data/models/tourist_info_model.dart';
import 'package:prepare_project/features/tourist/profile/data/repos/profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo{
  final ApiServices apiServices;
  ProfileRepoImpl(this.apiServices);
  @override
  Future<Either<Failure, TouristInfoModel>> getTourismInfo() async{
    try{
      var data=await apiServices.get(endPoint: '${homeEndPoint}getProfile',);
      TouristInfoModel infoModel= TouristInfoModel.fromJson(data['user']);
      return right(infoModel);
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
  Future<Either<Failure, TouristInfoModel>> updateTourismInfo({ required FormData infoModel})async {
    try
    {
      var data=await apiServices.postWithPhoto(endPoint: '${homeEndPoint}profileSetUp', data:infoModel);
      TouristInfoModel model= TouristInfoModel.fromJson(data['user']);
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