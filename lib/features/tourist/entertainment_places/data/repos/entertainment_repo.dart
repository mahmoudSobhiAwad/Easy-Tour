import 'package:dartz/dartz.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/features/tourist/entertainment_places/data/models/entertainment_place_model.dart';

abstract class EntertainmentPlacesRepo{
  Future<Either<Failure,EntertainmentPlacesModel>>getPlacesInfo(Map<String,dynamic>data);
  Future<Either<Failure,String>>toggleToFavourite();
}