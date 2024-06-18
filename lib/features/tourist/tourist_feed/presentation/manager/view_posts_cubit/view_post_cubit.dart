import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/function/set_app_state.dart';
import 'package:prepare_project/features/tourist/tourist_feed/data/model/post_model.dart';
import 'package:prepare_project/features/tourist/tourist_feed/presentation/manager/view_posts_cubit/view_post_states.dart';

class ViewPostsCubit extends Cubit<ViewPostStates>{
  ViewPostsCubit():super(InitialViewPostState());
  String sourceEmail=SetAppState.prefs?.getString('email')??"";
  final db = FirebaseFirestore.instance;
  final CollectionReference postsStream = FirebaseFirestore.instance.collection('posts');
  final Future<QuerySnapshot<Map<String, dynamic>>> postsFuture = FirebaseFirestore.instance.collection('posts').get();
  List<PostModel>postsList=[];
  void getData(List<QueryDocumentSnapshot<Map<String,dynamic>>>? snapshot){
    if(snapshot!=null){
      postsList=[];
      for (var docSnapshot in snapshot) {
        postsList.add(PostModel.fromFireStore(docSnapshot,SnapshotOptions()));
      }
    }

  }
  void getDataOnce(List<QueryDocumentSnapshot<Map<String,dynamic>>>? snapshot){
    if(snapshot!=null){
      postsList=[];
      for (var docSnapshot in snapshot) {
        if(docSnapshot['email']==sourceEmail){
          postsList.add(PostModel.fromFireStore(docSnapshot,SnapshotOptions()));
        }
      }
    }
  }
}