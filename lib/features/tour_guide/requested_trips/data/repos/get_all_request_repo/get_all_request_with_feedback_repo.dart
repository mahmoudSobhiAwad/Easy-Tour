import 'package:dartz/dartz.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/features/tour_guide/requested_trips/data/models/handle_request_model.dart';

abstract class GetAllRequestedTripRepo {
  Future<Either<Failure,List<RequestsTripForTGModel>>>getAllRequestedTrips();
  Future<Either<Failure,String>>handleRequestBack(Map<String,dynamic>parameters);
}