import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/core/utilities/constant_var/constant.dart';
import 'package:prepare_project/core/utilities/network/crud_dio.dart';
import 'package:prepare_project/features/tour_guide/private_tour/data/model/private_tour_model.dart';
import 'package:prepare_project/features/tour_guide/private_tour/data/repos/private_tour_repo.dart';

class PrivateTourRepoImp implements PrivateTourRepo{
  final ApiServices apiServices;
  PrivateTourRepoImp({required this.apiServices});
  @override
  Future<Either<Failure, String>> createPrivateTrip({required FormData tripModel}) async{
    try{
      var data=await apiServices.postWithPhoto(endPoint: '${homeEndPoint}myTrips/createTrip', data: tripModel);
      String trip=data['message'];
      return Right(trip);
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
  Future<Either<Failure, String>> deletePrivateTrip({required Map<String,dynamic>data}) async{
    try{
      var response=await apiServices.delete(endPoint: '${homeEndPoint}myTrips/deleteTrip', data: data);
      String trip=response['message'];
      return Right(trip);

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
  Future<Either<Failure, String>> editPrivateTrip({required FormData tripModel})async {
    try{
      var response=await apiServices.patchWithPhoto(endPoint: '${homeEndPoint}myTrips/editTrip', data: tripModel);
      String trip=response['message'];
      return Right(trip);

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
  Future<Either<Failure, List<Trip>>> getPrivateTrip() async{
    try{
      var response=await apiServices.get(endPoint: '${homeEndPoint}myTrips/getAllTrips',);
      List<Trip> trips=List<Trip>.from(response['trips'].map((x) => Trip.fromJson(x)));
      return Right(trips);

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