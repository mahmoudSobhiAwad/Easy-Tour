import 'package:dartz/dartz.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/features/tourist/nearby_places/data/models/nearby_places_model.dart';

abstract class NearbyPlacesRepo{
  Future<Either<Failure,List<NearbyPlacesModel>>>getNearbyPlace(Map<String,dynamic>parameters,{String?fieldMask});
}