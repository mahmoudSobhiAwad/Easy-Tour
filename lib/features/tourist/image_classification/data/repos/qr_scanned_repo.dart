import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/features/tourist/image_classification/data/models/qr_scanned_model.dart';

abstract class QrScannedRepo{
  Future<Either<Failure,QrScannedModel>>sendScannedQr({required dynamic data});

  Future<Either<Failure,String>>sendImageToClassify({required FormData data});
}
