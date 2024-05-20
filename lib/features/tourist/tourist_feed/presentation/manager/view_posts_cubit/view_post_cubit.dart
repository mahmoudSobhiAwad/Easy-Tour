import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/features/tourist/tourist_feed/data/model/post_model.dart';
import 'package:prepare_project/features/tourist/tourist_feed/presentation/manager/view_posts_cubit/view_post_states.dart';

class ViewPostsCubit extends Cubit<ViewPostStates>{
  ViewPostsCubit():super(InitialViewPostState());
  final db = FirebaseFirestore.instance;
  final CollectionReference postsStream = FirebaseFirestore.instance.collection('posts');
  List<PostModel>postsList=[];
  void getDate(List<QueryDocumentSnapshot<Map<String,dynamic>>>? snapshot){
    if(snapshot!=null){
      postsList=[];
      for (var docSnapshot in snapshot) {
        postsList.add(PostModel.fromFireStore(docSnapshot,SnapshotOptions()));
      }
    }

  }
}