import 'package:dartz/dartz.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/model/type_of_places_toursim.dart';

abstract class GenerateTripRepo {
  Future<Either<Failure,GeneratedTripModel>>requestToGenerateDate({required String data});
}