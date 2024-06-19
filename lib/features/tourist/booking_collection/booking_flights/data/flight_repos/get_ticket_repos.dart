import 'package:dartz/dartz.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/data/flight_models/get_tickets_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/data/flight_models/iata_codes_model.dart';

abstract class GetTicketsRepo{
  Future<Either<Failure,List<IatCodeModel>>>getMatchedAirPorts({required String query});

  Future<Either<Failure,List<GetTicketsModel>>>getTicketsOfTripByOfferSearch({required Map<String,dynamic>data,required String accessToken});

  Future<Either<Failure,String>>getAccessToken({required Map<String,dynamic>data});
}