import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/core/utilities/constant_var/constant.dart';
import 'package:prepare_project/core/utilities/network/crud_dio.dart';
import 'package:prepare_project/features/tourist/currency_converter/data/model/currency_converter_model.dart';
import 'package:prepare_project/features/tourist/currency_converter/data/repos/currency_repo.dart';

class CurrencyRepoImpl implements CurrencyRepo{
  final ApiServices apiServices;
  CurrencyRepoImpl({required this.apiServices});
  @override
  Future<Either<Failure, List<CurrencyCodesModel>>> getCurrencyCodes() async{
    try{
      var result=await apiServices.normalGet('${currencyConverterBaseUrl}codes');
      List<CurrencyCodesModel>currencyCodesList=[];
      for (var item in result['supported_codes']){
        currencyCodesList.add(CurrencyCodesModel.fromJson(item));
      }
      return right(currencyCodesList);
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
  Future<Either<Failure, num>> getConvertedCurrency({required String based,required String target,required num amount}) async{
    try{
      var result=await apiServices.normalGet('${currencyConverterBaseUrl}pair/$based/$target/$amount');
      num resultedAmount=result['conversion_result'];

      return right(resultedAmount);
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