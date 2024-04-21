import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/core/utilities/constant_var/constant.dart';
import 'package:prepare_project/core/utilities/network/crud_dio.dart';
import 'package:prepare_project/features/tourist/google_map/data/models/route_poly_lines_model.dart';
import 'package:prepare_project/features/tourist/google_map/data/models/text_search_model.dart';
import 'package:prepare_project/features/tourist/google_map/data/repo/text_search_repo/text_search_repo.dart';

class GoogleSearchRepoImp implements GoogleSearchRepo{
  final ApiServices apiServices;
  GoogleSearchRepoImp({required this.apiServices});
  @override
  Future<Either<Failure, List<TextSearchModel>>> getTextSearchList(Map<String, dynamic> parameters)async {
    try{
      var response=await apiServices.postGoogleNewApi(data:parameters,endPoint: 'searchText',fieldMask: fieldMaskForTextSearch);
      List<TextSearchModel> textSearchPlaces=[];
      for(var item in response['places']){
        textSearchPlaces.add(TextSearchModel.fromJson(item));
      }
      return right(textSearchPlaces);
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
  Future<Either<Failure, List<RoutePolyLinesModel>>> getRoutePolyLines(Map<String, dynamic> parameters) async{
    try{
      var response=await apiServices.postGoogleRouteApi(data:parameters);
      List<RoutePolyLinesModel> routePolyLinesList=[];
      for(var item in response['routes']){
        routePolyLinesList.add(RoutePolyLinesModel.fromJson(item));
      }
      return right(routePolyLinesList);
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