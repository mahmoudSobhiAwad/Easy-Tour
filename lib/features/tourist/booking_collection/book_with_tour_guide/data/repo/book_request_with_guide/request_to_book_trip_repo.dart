import 'package:dartz/dartz.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';

abstract class RequestToBookTripWithGuideRepo{
  Future<Either<Failure,void>>sendRequestToBook(Map<String,dynamic>parameters);
}