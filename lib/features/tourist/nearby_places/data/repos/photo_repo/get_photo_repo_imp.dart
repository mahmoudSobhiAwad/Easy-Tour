import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/core/utilities/network/crud_dio.dart';
import 'package:prepare_project/features/tourist/nearby_places/data/repos/photo_repo/get_photo_repo.dart';

class PhotoOfPlaceRepoImp implements PhotoOfPlaceRepo{
  final ApiServices apiServices;
  PhotoOfPlaceRepoImp({required this.apiServices});
  @override
  Future<Either<Failure, String>> getPhotoOfPlace(String parameters) async{
    try{
      var response=await apiServices.getPlacePhoto(data:parameters);
      String imageUri=response['photoUri'];
      return right(imageUri);
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