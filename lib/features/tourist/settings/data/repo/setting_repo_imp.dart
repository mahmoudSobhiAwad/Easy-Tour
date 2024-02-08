// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import 'package:prepare_project/core/errors/failure_dio.dart';
// import 'package:prepare_project/core/utilities/network/crud_dio.dart';
// import 'package:prepare_project/features/tourist/settings/data/repo/setting_repo.dart';
//
// class SettingRepoImp implements SettingRepo {
//   final ApiServices apiServices;
//   SettingRepoImp({required this.apiServices});
//   @override
//   Future<Either<Failure, String>> deleteAccount() async{
//     try{
//       var result= await apiServices.delete(endPoint: 'deleteUser',);
//       String response=result['message'];
//       return right(response);
//     }
//     catch(e){
//       if(e is DioException){
//         return left(ServerFailure.fromDioError(e));
//       }
//       else{
//         return left(ServerFailure(e.toString()));
//       }
//
//     }
//   }
//
// }