import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/core/utilities/constant_var/constant.dart';
import 'package:prepare_project/core/utilities/network/crud_dio.dart';
import 'package:prepare_project/features/tourist/chat_with_other/data/models/one_to_one_chat_model.dart';
import 'package:prepare_project/features/tourist/chat_with_other/data/repos/chat_oto/chat_oto_repo.dart';

class ChatOTORepoImp implements ChatOTORepo{
  final ApiServices apiServices;
  ChatOTORepoImp({required this.apiServices});
  @override
  Future<Either<Failure, GetOTOChatModel>> getAllChatOTO(String chatId)async {
    try{
      var response=await apiServices.get(endPoint: '${homeEndPointTourist}chat/getChat',chatID:chatId );
      GetOTOChatModel chat=GetOTOChatModel.fromJson(response['chat']);
      return right(chat);
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
  Future<Either<Failure, String>> sendMessageToOther(Map<String, dynamic> data) async{
    try{
      print(data);
      var response=await apiServices.post(endPoint:'${homeEndPointTourist}chat/sendMessage',data: data);
      String messageResponse=response['message'];
      return right(messageResponse);
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