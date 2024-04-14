import 'package:dartz/dartz.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';

abstract class PhotoOfPlaceRepo{
  Future<Either<Failure,String>>getPhotoOfPlace(String parameters);
}