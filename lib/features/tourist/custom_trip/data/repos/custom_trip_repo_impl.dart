import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/core/utilities/constant_var/constant.dart';
import 'package:prepare_project/core/utilities/network/crud_dio.dart';
import 'package:prepare_project/features/tourist/custom_trip/data/model/custom_trip_model.dart';
import 'package:prepare_project/features/tourist/custom_trip/data/repos/custom_trip_repo.dart';

class CustomTripRepoImpl implements CustomTripRepo{
  final ApiServices apiServices;
  CustomTripRepoImpl({required this.apiServices});

  @override
  Future<Either<Failure, void>> createCustomTrips({required Map<String, dynamic> data})async {
    try {
      void result =await apiServices.post(
        endPoint: '${homeEndPointTourist}book/custom/createCustomTrip',data: data);
      return Right(result);
    }
    catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, void>> deleteCustomTrip({required String tripId})async {
    try {
      void result =await apiServices.delete(
          endPoint: '${homeEndPointTourist}book/custom/deleteTrip?tripId=$tripId',);
      return Right(result);
    }
    catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, String>> editCustomTrip({required String tripId,required Map<String,dynamic>data})async {
    try {
      var result =await apiServices.putData(
        endPoint:'${homeEndPointTourist}book/custom/updateTrip?tripId=$tripId',data: data);
      return Right(result['message']);
    }
    catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<CustomTripModel>>> getAllCustomTrips() async{
    try {
      List<CustomTripModel>tripList=[];
      var result =await apiServices.get(endPoint: '${homeEndPointTourist}book/custom/getTrips',);
      if(result.isNotEmpty)
      {
      tripList=List<CustomTripModel>.from(result['trips'].map((x) => CustomTripModel.fromJson(x)));
      }
      return Right(tripList);
    }
    catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

}