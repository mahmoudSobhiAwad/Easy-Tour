import 'package:dartz/dartz.dart';
import 'package:prepare_project/features/tourist/chat_bot/data/model/chat_bot_model.dart';

import '../../../../../core/errors/failure_dio.dart';


abstract class ChatBotRepo{
  Future<Either<Failure,ChatBotModel>>sendRequest({required Map<String,dynamic> data});
}