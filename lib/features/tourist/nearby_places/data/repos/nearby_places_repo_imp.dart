import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/core/utilities/constant_var/constant.dart';
import 'package:prepare_project/core/utilities/network/crud_dio.dart';
import 'package:prepare_project/features/tourist/nearby_places/data/models/nearby_places_model.dart';
import 'package:prepare_project/features/tourist/nearby_places/data/repos/nearby_places_repo.dart';

class NearbyPlacesRepoImpl implements NearbyPlacesRepo{
  final ApiServices apiServices;
  NearbyPlacesRepoImpl({required this.apiServices});
  @override
  Future<Either<Failure, List<NearbyPlacesModel>>> getNearbyPlace(Map<String,dynamic>parameters,{String?fieldMask}) async{
    try{
      var response=await apiServices.postGoogleNewApi(data:parameters,endPoint: 'searchNearby',fieldMask: fieldMask??fieldMaskForNearbyPlaces);
      List<NearbyPlacesModel> nearbyPlacesList=[];
      for(var item in response['places']){
        nearbyPlacesList.add(NearbyPlacesModel.fromJson(item));
      }
      return right(nearbyPlacesList);
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