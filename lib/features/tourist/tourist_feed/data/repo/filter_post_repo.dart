import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/core/utilities/network/crud_dio.dart';
import 'package:prepare_project/features/tourist/tourist_feed/data/model/filter_model.dart';

abstract class FilterPostRepo{
  Future<Either<Failure,FilterPostModel>>getFilteredPosts({required Map<String, dynamic> info});
}
class FilterPostRepoImpl implements FilterPostRepo{
  final ApiServices apiServices;
  FilterPostRepoImpl({required this.apiServices});
  @override
  Future<Either<Failure, FilterPostModel>> getFilteredPosts({required Map<String,dynamic>info}) async{
    try
    {
      var result=await apiServices.normalPost('http://35.175.102.243:8000/post_filteration', data:info);
      print(result);
      FilterPostModel filterPostModel=FilterPostModel.fromJson(result);
      return right(filterPostModel);
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