import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/core/utilities/network/crud_dio.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/data/flight_models/get_tickets_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/data/flight_models/iata_codes_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/data/flight_repos/get_ticket_repos.dart';

class GetTicketsRepoImpl implements GetTicketsRepo{
  final ApiServices apiServices;
  GetTicketsRepoImpl({required this.apiServices});
  @override
  Future<Either<Failure, List<IatCodeModel>>> getMatchedAirPorts({required String query}) async{
    try {
      var response = await apiServices.normalGet('http://localhost:8000/search?cityName=$query',);
      List<IatCodeModel> iataCodesList = List<IatCodeModel>.from(
          response['data'].map((x) => IatCodeModel.fromJson(x)));
      return Right(iataCodesList);
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
  Future<Either<Failure, List<GetTicketsModel>>> getTicketsOfTripByOfferSearch({required Map<String, dynamic> data,required String accessToken}) async{
    try {
      var response = await apiServices.normalPost(
          'https://test.api.amadeus.com/v2/shopping/flight-offers',
          data: data,
          header: {
            'X-HTTP-Method-Override':'GET',
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/x-www-form-urlencoded',
          });
      List<GetTicketsModel> tickets = List<GetTicketsModel>.from(response['data'].map((x) => GetTicketsModel.fromJson(x)));
      return Right(tickets);
    }
    catch(e){
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, String>> getAccessToken({required Map<String, dynamic> data}) async{
    try {
      var response = await apiServices.normalPost(
          'https://test.api.amadeus.com/v1/security/oauth2/token',
          data: data,
          header: {
            'Content-Type': 'application/x-www-form-urlencoded',
          });
      return right(response['access_token']);
    }
    catch(e){
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

}