import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/core/utilities/network/crud_dio.dart';
import 'package:prepare_project/features/tourist/chat_bot/data/model/chat_bot_model.dart';
import 'package:prepare_project/features/tourist/chat_bot/data/repo/chat_bot_repo.dart';

class ChatBotRepoImp extends ChatBotRepo{
  final ApiServices apiServices;
  ChatBotRepoImp({required this.apiServices});
  @override
  Future<Either<Failure, ChatBotModel>> sendRequest({required Map<String,dynamic> data})async {
    try{
      var result=await apiServices.askQuestionWithChatBot(data:data);
      ChatBotModel model =ChatBotModel.fromJson(result);
      return right(model);
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