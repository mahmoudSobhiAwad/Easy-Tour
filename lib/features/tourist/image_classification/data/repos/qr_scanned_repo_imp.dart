import 'package:dartz/dartz.dart';
import 'package:prepare_project/features/tourist/image_classification/data/repos/qr_scanned_repo.dart';
import 'package:dio/dio.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/core/utilities/network/crud_dio.dart';
import 'package:prepare_project/features/tourist/image_classification/data/models/qr_scanned_model.dart';
class QrScannedRepoImp implements QrScannedRepo{
  final ApiServices apiServices;
  QrScannedRepoImp({required this.apiServices});
  @override
  Future<Either<Failure, QrScannedModel>> sendScannedQr({required dynamic data}) async{
    try{
      var result=await apiServices.sendQrCode(data:data);
      QrScannedModel model =QrScannedModel.fromJson(result);
      return right(model);
    }
    catch(e){
      if(e is DioException){
        return left(ServerFailure.fromDioError(e));
      }
      else{
        return left(ServerFailure(e.toString()));
      }
    }
  }
  @override
  Future<Either<Failure, String>> sendImageToClassify({required FormData data})async {
    try
    {
      var result=await apiServices.postWithPhoto(endPoint: 'http://52.3.241.245:8000/classify_image/', data:data,out: true);
      String response= result['predictions'];
      return right(response);
    }
    catch(e){
      if(e is DioException){
        return left(ServerFailure.fromDioError(e));
      }
      else{
        return left(ServerFailure(e.toString()));
      }
    }
  }

}