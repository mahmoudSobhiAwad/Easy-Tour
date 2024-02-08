
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/features/tourist/profile/data/models/tourist_info_model.dart';
abstract class ProfileRepo{
  Future<Either<Failure,TouristInfoModel>>getTourismInfo();
  Future<Either<Failure,TouristInfoModel>>updateTourismInfo({required FormData infoModel,});
}
