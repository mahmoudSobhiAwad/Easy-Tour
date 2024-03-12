import 'package:dartz/dartz.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/features/tourist/chat_with_other/data/models/recent_chat_model.dart';
import 'package:prepare_project/features/tourist/chat_with_other/data/models/view_guide_meta_data.dart';
abstract class GuideMetaDataAndChatRecentRepo{
Future<Either<Failure,List<ViewGuideMetaDataModel>>>getTourGuideMetaData();
Future<Either<Failure,List<RecentChatModel>>>getRecentChatList();
}