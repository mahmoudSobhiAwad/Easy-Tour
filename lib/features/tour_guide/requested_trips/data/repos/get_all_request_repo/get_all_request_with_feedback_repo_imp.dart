import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/core/utilities/constant_var/constant.dart';
import 'package:prepare_project/core/utilities/network/crud_dio.dart';
import 'package:prepare_project/features/tour_guide/requested_trips/data/models/handle_request_model.dart';
import 'package:prepare_project/features/tour_guide/requested_trips/data/repos/get_all_request_repo/get_all_request_with_feedback_repo.dart';

class GetAllRequestedTripRepoImpl implements GetAllRequestedTripRepo{
  final ApiServices apiServices;
  GetAllRequestedTripRepoImpl({required this.apiServices});
  @override
  Future<Either<Failure, List<RequestsTripForTGModel>>> getAllRequestedTrips() async{
    try{
      var data=await apiServices.get(endPoint: '${homeEndPointTourGuide}notification/getAllRequests',);
      List<RequestsTripForTGModel>requestsList=[];
      for(var item in data['requests']){
        requestsList.add(RequestsTripForTGModel.fromJson(item));
      }
      return Right(requestsList);
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
  Future<Either<Failure, String>> handleRequestBack(Map<String, dynamic> parameters) async{
    try{
      var data=await apiServices.patch(endPoint: '${homeEndPointTourGuide}notification/handleRequest', data: parameters,);
      String message=data['message'];
      return Right(message);
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