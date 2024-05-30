import 'package:dartz/dartz.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/models/get_availbitly_room_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/models/get_hotel_model.dart';

abstract class GetHotelRepo{
  Future<Either<Failure,CompleteHotelModel>>getAllHotelsInDestination({required String destCode,int?from,int?to});
  Future<Either<Failure,List<GetAvailableRoomsModel>>>getAvailableRooms({required Map<String,dynamic>toJsonModel});
}