import 'package:dartz/dartz.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/features/tourist/google_map/data/models/route_poly_lines_model.dart';
import 'package:prepare_project/features/tourist/google_map/data/models/text_search_model.dart';

abstract class GoogleSearchRepo{
  Future<Either<Failure,List<TextSearchModel>>>getTextSearchList(Map<String,dynamic>parameters);
  Future<Either<Failure,List<RoutePolyLinesModel>>>getRoutePolyLines(Map<String,dynamic>parameters);
}