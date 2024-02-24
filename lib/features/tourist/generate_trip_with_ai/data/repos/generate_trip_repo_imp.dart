import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/core/utilities/network/crud_dio.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/model/type_of_places_toursim.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/repos/generate_trip_repo.dart';

class GenerateTripRepoImp implements GenerateTripRepo{
  final ApiServices apiServices;
  GenerateTripRepoImp({required this.apiServices});
  @override
  Future<Either<Failure, GeneratedTripModel>> requestToGenerateDate({required String data}) async{
    try{
      var result=await apiServices.requestGenerateTrip(data: data);
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

}