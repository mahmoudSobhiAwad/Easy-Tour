import 'package:dartz/dartz.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/features/tourist/trip_history/data/model/trip_manager_model.dart';

abstract class TripManagerRepo {
  Future<Either<Failure,TripManagerModel>>getAllTripsManager();

  //Future<Either<Failure,List<TripManagerModel>>>repeatTripsManager();

  //Future<Either<Failure,List<TripManagerModel>>>delete();
}