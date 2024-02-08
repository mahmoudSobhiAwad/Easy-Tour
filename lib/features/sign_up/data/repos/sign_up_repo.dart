import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import '../model/toursim_sign_up_model.dart';

abstract class SignUpRepo{
  Future<Either<Failure,String >>signUpAsTourist(TourismSignUpModel model);
  Future<Either<Failure,String >>signUpAsTourGuide(FormData model);

}


