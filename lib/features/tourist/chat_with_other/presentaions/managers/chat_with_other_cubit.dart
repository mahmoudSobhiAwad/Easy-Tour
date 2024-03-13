import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/features/tourist/chat_with_other/data/models/recent_chat_model.dart';
import 'package:prepare_project/features/tourist/chat_with_other/data/models/view_guide_meta_data.dart';
import 'package:prepare_project/features/tourist/chat_with_other/data/repos/get_guide_meta_data/get_guide_meta_data_repo_imp.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/managers/chat_with_other_states.dart';

class TouristChatWithOtherCubit extends Cubit<TouristsChatWithOtherStates>{
  TouristChatWithOtherCubit({required this.guideMetaDataRepoImp}):super(InitialTouristsChatWithOtherStates());
  bool isLoadingGuides=false;
  bool isLoadingRecentChats=false;
  final GuideMetaDataAndChatRecentRepoImp guideMetaDataRepoImp;
  List<ViewGuideMetaDataModel> tourGuidesList=[];
  List<RecentChatModel> chatsList=[];
  void getTourGuidesToChatWith()async{
    isLoadingGuides=true;
    emit(LoadingGetGuidesMetaDataState());
    var result=await guideMetaDataRepoImp.getTourGuideMetaData();
    result.fold(
            (failure){
              isLoadingGuides=false;
              emit(FailureGetGuidesMetaDataState(errMessage: failure.errMessage));
            },
            (tourGuides){
              tourGuidesList.addAll(tourGuides);
              emit(SuccessGetGuidesMetaDataState());
              isLoadingGuides=false;
            }
    );
  }
  void getRecentChats()async{
    isLoadingRecentChats=true;
    emit(LoadingGetChatsMetaDataState());
    var result=await guideMetaDataRepoImp.getRecentChatList();
    result.fold(
            (failure){
              isLoadingRecentChats=false;
              log(failure.errMessage.toString());
              emit(FailureGetChatsMetaDataState(errMessage: failure.errMessage));
              },
            (chats){
              chatsList.addAll(chats);
              emit(SuccessGetChatsMetaDataState());
              isLoadingRecentChats=false;
            }
    );
  }
}