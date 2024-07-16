import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/core/utilities/constant_var/constant.dart';
import 'package:prepare_project/core/utilities/network/crud_dio.dart';
import 'package:prepare_project/features/tour_guide/profile/data/model/guide_personal_info_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/data/repo/get_guide_info_repo/get_guide_info_repo.dart';


class GetGuideInfoForTouristRepImp implements GetGuideInfoForTouristRep{
  final ApiServices apiServices;
  GetGuideInfoForTouristRepImp({required this.apiServices});
  @override
  Future<Either<Failure, TourGuidePersonalInfoModel>> getTourGuideInfoForTouristToView(Map<String, dynamic> data)async {
    try{
    var response=await apiServices.get(endPoint:'${homeEndPointTourist}book/TGtrip/viewTourGuide',data: data);
    TourGuidePersonalInfoModel model=TourGuidePersonalInfoModel.fromJson(response['tour_guide']);
    return Right(model);
    }
    catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }


}