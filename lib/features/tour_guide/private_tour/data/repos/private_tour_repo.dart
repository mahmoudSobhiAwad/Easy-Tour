import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/features/tour_guide/private_tour/data/model/private_tour_model.dart';
abstract class PrivateTourRepo{
Future<Either<Failure,String>>createPrivateTrip({required FormData tripModel});
Future<Either<Failure,List<Trip>>>getPrivateTrip();
Future<Either<Failure,String>>editPrivateTrip({required FormData tripModel});
Future<Either<Failure,String>>deletePrivateTrip({required Map<String,dynamic>data});
}