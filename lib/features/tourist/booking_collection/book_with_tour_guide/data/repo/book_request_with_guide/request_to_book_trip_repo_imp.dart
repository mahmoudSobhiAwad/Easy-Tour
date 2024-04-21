import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/core/utilities/network/crud_dio.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/data/repo/book_request_with_guide/request_to_book_trip_repo.dart';

import '../../../../../../../core/utilities/constant_var/constant.dart';

class RequestToBookTripWithGuideRepoImp implements RequestToBookTripWithGuideRepo{
  final ApiServices apiServices;
  RequestToBookTripWithGuideRepoImp({required this.apiServices});
  @override
  Future<Either<Failure, void>> sendRequestToBook(Map<String,dynamic>parameters) async{
    try{
      await apiServices.post(endPoint:'${homeEndPointTourist}book/TGtrip/tripRequest',data: parameters);
      return right(null);
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