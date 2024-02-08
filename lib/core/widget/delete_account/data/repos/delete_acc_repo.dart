import 'package:dartz/dartz.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';

abstract class DeleteAccRepo{
  Future<Either<Failure,String>>checkOldPassword({required String oldPass});
  Future<Either<Failure,String>>deleteAccount();
}
