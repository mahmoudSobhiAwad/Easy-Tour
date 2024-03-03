import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/core/utilities/constant_var/constant.dart';
import 'package:prepare_project/core/utilities/network/crud_dio.dart';
import 'package:prepare_project/features/tourist/entertainment_places/data/models/entertainment_place_model.dart';
import 'package:prepare_project/features/tourist/entertainment_places/data/repos/entertainment_repo.dart';

class EntertainmentPlaceRepoImp implements EntertainmentPlacesRepo{
  final ApiServices apiServices;
  EntertainmentPlaceRepoImp({required this.apiServices});
  @override
  Future<Either<Failure, EntertainmentPlacesModel>> getPlacesInfo(Map<String,dynamic>data) async{
    try{
      var result =await apiServices.get(endPoint: '${homeEndPointTourist}discoverPlaces/entertainment/getAllPlaces',data: data);
      EntertainmentPlacesModel model=EntertainmentPlacesModel.fromJson(result);
      return right(model);
    }
    catch(e) {
      if(e is DioException){
        return left(ServerFailure.fromDioError(e));
      }
      else{
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, String>> toggleToFavourite() {
    throw UnimplementedError();
  }
  
}