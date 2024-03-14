import 'package:dartz/dartz.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/features/tourist/chat_with_other/data/models/one_to_one_chat_model.dart';

abstract class ChatOTORepo{
  Future<Either<Failure,GetOTOChatModel>>getAllChatOTO(String chatID);
  Future<Either<Failure,String>>sendMessageToOther(Map<String,dynamic>data);
}