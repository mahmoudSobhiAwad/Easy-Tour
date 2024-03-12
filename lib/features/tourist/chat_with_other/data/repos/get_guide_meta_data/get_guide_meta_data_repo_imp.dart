import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/core/utilities/constant_var/constant.dart';
import 'package:prepare_project/core/utilities/network/crud_dio.dart';
import 'package:prepare_project/features/tourist/chat_with_other/data/models/recent_chat_model.dart';
import 'package:prepare_project/features/tourist/chat_with_other/data/models/view_guide_meta_data.dart';
import 'package:prepare_project/features/tourist/chat_with_other/data/repos/get_guide_meta_data/get_guide_meta_data_repo.dart';
class GuideMetaDataAndChatRecentRepoImp implements GuideMetaDataAndChatRecentRepo{
  final ApiServices apiServices;
  GuideMetaDataAndChatRecentRepoImp({required this.apiServices});
  @override
  Future<Either<Failure, List<ViewGuideMetaDataModel>>> getTourGuideMetaData() async{
    try{
      var response=await apiServices.get(endPoint: '${homeEndPointTourist}chat/getTGMeta');
      List<ViewGuideMetaDataModel> model=List<ViewGuideMetaDataModel>.from(
          response['tourGuides'].map((tourGuide)=>ViewGuideMetaDataModel.fromJson(tourGuide))
      );
      return right(model);
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
  Future<Either<Failure, List<RecentChatModel>>> getRecentChatList() async{
    try{
      var response=await apiServices.get(endPoint: '${homeEndPointTourist}chat/getRecentChats');
      List<RecentChatModel> chats=List<RecentChatModel>.from(
          response['chats'].map((recentChat)=>ViewGuideMetaDataModel.fromJson(recentChat))
      );
      return right(chats);
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