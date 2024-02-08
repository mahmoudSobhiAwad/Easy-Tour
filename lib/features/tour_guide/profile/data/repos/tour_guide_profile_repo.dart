import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/features/tour_guide/profile/data/model/guide_personal_info_model.dart';
abstract class TourGuideProfileRepo
{
  Future<Either<Failure,TourGuidePersonalInfoModel>>getTourGuideInfo();
  Future<Either<Failure,TourGuidePersonalInfoModel>>updatePersonalInfo({required FormData infoModel,});
  Future<Either<Failure,TourGuidePersonalInfoModel>>updateContactInfo({required FormData infoModel});
}
