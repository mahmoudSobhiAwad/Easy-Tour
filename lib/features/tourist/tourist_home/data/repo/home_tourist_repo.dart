import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure_dio.dart';

abstract class HomeTouristRepo{
  Future<Either<Failure,String>>logOut();
}
