import 'package:dartz/dartz.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/model/generated_trip_model.dart';
import '../../../../../core/errors/failure_dio.dart';

abstract class HomeTouristRepo{
  Future<Either<Failure,String>>logOut();
  Future<Either<Failure,List<Place>>>getBestDestination({int?pageNum,String?category,int?maxLength});
}
