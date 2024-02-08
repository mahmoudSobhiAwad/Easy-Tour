import 'package:dartz/dartz.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';

abstract class ChangePasswordRepo{
  Future<Either<Failure,String>>checkOldPassword({required String oldPass});
  Future<Either<Failure,String>>updateNewPassword({required Map<String,dynamic>passwords});
}