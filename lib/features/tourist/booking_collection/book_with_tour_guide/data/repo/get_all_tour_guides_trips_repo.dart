import 'package:dartz/dartz.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/features/tour_guide/private_tour/data/model/private_tour_model.dart';

abstract class TourGuideTripsForTouristRepo{
  Future<Either<Failure,List<Trip>>>getAllTourGuideTrips();
}