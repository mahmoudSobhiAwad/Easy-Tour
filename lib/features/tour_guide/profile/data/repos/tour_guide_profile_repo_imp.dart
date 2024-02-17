import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/core/utilities/constant_var/constant.dart';
import 'package:prepare_project/core/utilities/network/crud_dio.dart';
import 'package:prepare_project/features/tour_guide/profile/data/model/guide_personal_info_model.dart';
import 'package:prepare_project/features/tour_guide/profile/data/repos/tour_guide_profile_repo.dart';

class TourGuideProfileRepoImp implements TourGuideProfileRepo{
  final ApiServices apiServices;
  TourGuideProfileRepoImp({required this.apiServices});
  @override
  Future<Either<Failure, TourGuidePersonalInfoModel>> getTourGuideInfo() async{
    // TODO: implement getTourGuideInfo
    try
    {
      var data=await apiServices.get(endPoint: '${homeEndPointTourGuide}profile/getProfile',);
      TourGuidePersonalInfoModel infoModel= TourGuidePersonalInfoModel.fromJson(data['user']);
      return right(infoModel);
    }
    catch(e)
    {
      if(e is DioException){
        return left(ServerFailure.fromDioError(e));
      }
      else{
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, TourGuidePersonalInfoModel>> updateContactInfo({required FormData infoModel }) async{
    try
    {
      var data=await apiServices.patchWithPhoto(endPoint: '${homeEndPointTourGuide}profile/updateProfile', data:infoModel);
      TourGuidePersonalInfoModel model= TourGuidePersonalInfoModel.fromJson(data['updated_user']);
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
  Future<Either<Failure, TourGuidePersonalInfoModel>> updatePersonalInfo({required FormData infoModel}) async{
    try
    {
      var data=await apiServices.patchWithPhoto(endPoint: '${homeEndPointTourGuide}profile/updateProfile', data:infoModel);
      TourGuidePersonalInfoModel model= TourGuidePersonalInfoModel.fromJson(data['updated_user']);
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
  Future<Either<Failure, TourGuidePersonalInfoModel>> updateCvFile({required FormData infoModel}) async{
    try
    {
      var data=await apiServices.patchWithPhoto(endPoint: '${homeEndPointTourGuide}profile/updateProfile', data:infoModel);
      TourGuidePersonalInfoModel model= TourGuidePersonalInfoModel.fromJson(data['updated_user']);
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