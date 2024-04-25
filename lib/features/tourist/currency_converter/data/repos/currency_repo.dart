import 'package:dartz/dartz.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/features/tourist/currency_converter/data/model/currency_converter_model.dart';
abstract class CurrencyRepo{
Future<Either<Failure,List<CurrencyCodesModel>>>getCurrencyCodes();
Future<Either<Failure,num>>getConvertedCurrency({required String based,required String target,required num amount});
}