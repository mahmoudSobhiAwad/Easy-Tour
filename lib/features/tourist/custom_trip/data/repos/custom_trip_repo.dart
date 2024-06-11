import 'package:dartz/dartz.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/features/tourist/custom_trip/data/model/custom_trip_model.dart';

abstract class CustomTripRepo{
  Future<Either<Failure,List<CustomTripModel>>>getAllCustomTrips();
  Future<Either<Failure,void>>createCustomTrips({required Map<String,dynamic>data});
  Future<Either<Failure,String>>editCustomTrip({required String tripId,required Map<String,dynamic>data});
  Future<Either<Failure,void>>deleteCustomTrip({required String tripId});
}