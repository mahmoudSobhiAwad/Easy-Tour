import 'package:dartz/dartz.dart';

import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/features/tour_guide/profile/data/model/guide_personal_info_model.dart';
abstract class GetGuideInfoForTouristRep{
  Future<Either<Failure,TourGuidePersonalInfoModel>>getTourGuideInfoForTouristToView(Map<String,dynamic>data);
}