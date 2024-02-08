import 'package:dartz/dartz.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/features/sign_up/data/model/tour_guide_model.dart';
import '../model/toursim_sign_in_model.dart';

abstract class LoginRepo{
  Future<Either<Failure,TourismSignInModel>>loginAsTourism(Map<String,dynamic> data);
  Future<Either<Failure,TourGuideSignUpModel>>loginAsTourGuide(Map<String,dynamic> data);
}
