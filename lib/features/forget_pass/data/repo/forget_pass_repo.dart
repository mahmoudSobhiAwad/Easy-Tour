import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure_dio.dart';
import '../model/forget_pass_model.dart';

abstract class ForgetPassRepo{
  Future<Either<Failure,ResetPassModel>>sendEmailForgetTouristPassword(Map<String,dynamic> data);
  Future<Either<Failure,ResetPassModel>>sendEmailForgetTourGuidePassword(Map<String,dynamic> data);
  Future<Either<Failure,ResetPassModel>>resetTouristPassword(Map<String,dynamic> data,);
  Future<Either<Failure,ResetPassModel>>resetTourGuidePassword(Map<String,dynamic> data,);
}