import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/core/utilities/constant_var/constant.dart';
import 'package:prepare_project/core/utilities/network/crud_dio.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/repos/generate_trip_repo.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/model/generated_trip_model.dart';
class GenerateTripRepoImp implements GenerateTripRepo{
  final ApiServices apiServices;
  late dynamic tripUploaded;
  GenerateTripRepoImp({required this.apiServices});
  @override
  Future<Either<Failure, GeneratedTripModel>> requestToGenerateDate({required String data}) async{
    try{
      var result=await apiServices.requestGenerateTrip(data: data);
      print(result);
      tripUploaded=result;
      GeneratedTripModel model=GeneratedTripModel.fromJson(result);
      return Right(model);
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
  Future<Either<Failure, String>> uploadGeneratedDate({required Map<String, dynamic> data}) async{
    try{
      data.addAll({'tripDetails':tripUploaded});
      var result=await apiServices.dynamicPost(data: data, endPoint:'${homeEndPointTourist}AI/trip/createTrip');
      return Right(result['message']);
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