import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure_dio.dart';

abstract class HomeTourGuideRepo{
  Future<Either<Failure,String>>logOut();
}
