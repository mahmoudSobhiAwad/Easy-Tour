import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:crypto/crypto.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/core/utilities/constant_var/constant.dart';
import 'package:prepare_project/core/utilities/network/crud_dio.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/models/get_availbitly_room_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/models/get_hotel_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/repos/get_hotels_repo/get_hotels_repo.dart';

class GetHotelsRepoImpl implements GetHotelRepo{
  final ApiServices apiServices;
  GetHotelsRepoImpl({required this.apiServices});
  @override
  Future<Either<Failure,CompleteHotelModel>> getAllHotelsInDestination({required String destCode,int? from,int?to}) async{
    try{
      var response=await apiServices.normalGet('$hotelBookingUrl/hotel-content-api/1.0/hotels?destinationCode=$destCode&countryCode=EG&language=ENG&from=${from??0}&to=${to??10}&useSecondaryLanguage=false', header: toJson());
      CompleteHotelModel hotelModel=CompleteHotelModel.fromJson(response);
      return Right(hotelModel);
    }
    catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<GetAvailableRoomsModel>>> getAvailableRooms({required Map<String, dynamic> toJsonModel}) async{
    try{
      List<GetAvailableRoomsModel>hotels=[];
      var response=await apiServices.normalPost('$hotelBookingUrl/hotel-api/1.0/hotels',header: toJson(),data: toJsonModel);
      if(response['hotels']['hotels']!=null){
        for(var item in response['hotels']['hotels'][0]['rooms']){
          hotels.add(GetAvailableRoomsModel.fromJson(item));
        }
        return  Right(hotels);
      }
      return Right(hotels);
    }
    catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

}
const apiKey='879188c2f050deef0110f78087920685';
const secret='fa2f9bd32a';
Map<String,dynamic>toJson(){
  String xSignature=getXSignature();
  return{
    'Api-key': apiKey,
    'X-Signature': xSignature,
    'Accept':'application/json',
    'Accept-Encoding':'gzip',
  };
}
int getUtcTimestampInEpochSeconds() {
  return (DateTime.now().millisecondsSinceEpoch ~/ 1000);
}
String getXSignature(){
  int utcDate = getUtcTimestampInEpochSeconds();
  String assemble = apiKey+secret+utcDate.toString();
  final bytes = utf8.encode(assemble);
  final digest = sha256.convert(bytes);
  return digest.toString();
}