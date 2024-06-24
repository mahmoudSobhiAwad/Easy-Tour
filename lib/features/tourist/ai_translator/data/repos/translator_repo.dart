import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/core/utilities/network/crud_dio.dart';

abstract class TranslatorRepo{
  Future<Either<Failure,String>>sendRequest({required Map<String,dynamic> data});
}
class TranslatorRepoImp implements TranslatorRepo {
  final ApiServices apiServices;
  TranslatorRepoImp({required this.apiServices});
  @override
  Future<Either<Failure, String>> sendRequest({required Map<String, dynamic> data}) async{
    try{
      var result=await apiServices.normalPost('http://34.230.37.188:8000/translator',data:data);
      String response =result['response'];
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