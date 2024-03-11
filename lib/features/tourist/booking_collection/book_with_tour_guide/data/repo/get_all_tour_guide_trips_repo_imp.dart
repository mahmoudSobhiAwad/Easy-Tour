import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/core/utilities/constant_var/constant.dart';
import 'package:prepare_project/core/utilities/network/crud_dio.dart';
import 'package:prepare_project/features/tour_guide/private_tour/data/model/private_tour_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/data/repo/get_all_tour_guides_trips_repo.dart';

class TourGuideTripsForTouristRepoImp implements TourGuideTripsForTouristRepo {
  final ApiServices apiServices;

  TourGuideTripsForTouristRepoImp({required this.apiServices});
  @override
  Future<Either<Failure, List<Trip>>> getAllTourGuideTrips(Map<String, dynamic>? queryParam) async {
    try {
      var response = await apiServices.get(
        queryParam: queryParam,
        endPoint: '${homeEndPointTourist}book/TGtrip/getAllTrips',);
      List<Trip> trips = List<Trip>.from(
          response['tourGuideTrips'].map((x) => Trip.fromJson(x)));
      return Right(trips);
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
  Future<Either<Failure,int>> getAllTripsLength()async {
    try{
      var response=await apiServices.get(endPoint: '${homeEndPointTourist}book/TGtrip/getTripsLength',);
      int number=response['tripsLength'];
      return Right(number);
    }
    catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }
}