import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:prepare_project/core/utilities/function/set_app_state.dart';
import 'package:prepare_project/features/tourist/tourist_feed/data/model/filter_model.dart';
import 'package:prepare_project/features/tourist/tourist_feed/data/model/post_model.dart';
import 'package:prepare_project/features/tourist/tourist_feed/data/repo/filter_post_repo.dart';
import 'package:prepare_project/features/tourist/tourist_feed/presentation/manager/create_post_cubit/create_post_states.dart';
import 'package:video_player/video_player.dart';

class CreatePostCubit extends Cubit<CreatePostStates>{
  CreatePostCubit({required this.filterPostRepoImpl}):super(InitialCreatePostState());
  ImagePicker picker=ImagePicker();
  final FilterPostRepoImpl filterPostRepoImpl;
  List<MediaPathWithType>mediaPaths=[];
  late ChewieController chewieController;
  late VideoPlayerController videoPlayerController;
  List<MediaPathWithType>uploadedImagesLinks=[];
  final TextEditingController controller=TextEditingController();
  String sourceEmail=SetAppState.prefs?.getString('email')??"";
  String role=SetAppState.prefs?.getString('role')??"";
  String name=SetAppState.prefs?.getString('name')??"";
  final storageRef = FirebaseStorage.instance.ref('post');
  final db = FirebaseFirestore.instance;
  int userPostNum=0;
  void getImage()async{

   await picker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        mediaPaths.add(MediaPathWithType(path: value.path, type: MediaType.image));
        emit(AddMediaToPostState());
      }
    });
  }
  void getImagesFromGallery()async{
    await picker.pickMultiImage().then((value) {
      if(value.isNotEmpty){
        for(var item in value){
          mediaPaths.add(MediaPathWithType(path: item.path, type: MediaType.image));
        }
        emit(AddMediaToPostState());
      }
    });
  }
  void removeSpecificImage(int index){
    mediaPaths.removeAt(index);
    emit(RemoveSelectedMediaState());
  }

  Future<void>uploadFileToFireBase()async{
    emit(LoadingUploadImagesState());
    for(var item in mediaPaths){
      var fileName=basename(item.path);
      var imageRef=storageRef.child(sourceEmail).child('${item.type==MediaType.image?"images":"videos"}').child('${DateTime.now().millisecondsSinceEpoch}_$fileName');
      File file=File(item.path);
      try {
        await imageRef.putFile(file);
        String downloadLink=await imageRef.getDownloadURL();
        uploadedImagesLinks.add(MediaPathWithType(path: downloadLink, type: item.type));
        emit(SuccessUploadImagesState());
      } on firebase_core.FirebaseException catch (e) {
        emit(FailureUploadImagesState(errMessage: e.message.toString()));
      }
    }
  }
  Future<void> getCollectionLength() async {
    try{
    await db.collection('posts').get().then((value) {
      userPostNum= value.size;
    });
    emit(SuccessGetLengthOfCollectionState());
    }
    on firebase_core.FirebaseException catch(e){
      emit(FailureGetLengthOfCollectionState(errMessage: e.message.toString()));
    }
  }

  Future<void>createPost()async{
    emit(LoadingUploadPostState());
    await getCollectionLength();
    final post=PostModel(
        sourceEmail: sourceEmail,
        role: role,
        publisherName: name,
        postDate:DateTime.now().toString(),
        postText:controller.text,
        mediaPosts:uploadedImagesLinks,
    );
    final docRef = db
        .collection("posts")
        .withConverter(
      fromFirestore: PostModel.fromFireStore,
      toFirestore: (PostModel city, options) => post.toFireStore(),
    ).doc("postData${userPostNum+1}");
    try{
    await docRef.set(post);
    emit(SuccessUploadPostState());
    }
        on firebase_core.FirebaseException catch(e){
          emit(FailureUploadPostState(errMessage: e.message.toString()));
        }
  }

  Future<void>uploadFullPost()async{
    if(mediaPaths.isNotEmpty){
      await uploadFileToFireBase().then((value)async {
        if(uploadedImagesLinks.isNotEmpty){
          await filterPost();
         // await createPost();
        }
      });
    }
    else{
      if(controller.text.isNotEmpty)
      {
      await createPost();
      }
    }
  }

  Future<void>filterPost()async{
  if(uploadedImagesLinks.isNotEmpty){
    emit(LoadingFilterPosts());
    var result=await filterPostRepoImpl.getFilteredPosts(info: FilterPostModel(
      imageLinks:getStringList(MediaType.image) ,
      videoLinks:getStringList(MediaType.video),
      text: controller.text,
    ).toJson());
    result.fold((failure) {
      emit(FailureFilterPosts(errMessage: failure.errMessage));
    }, (success){

      emit(SuccessFilterPosts());
    });
  }
  }
  List<String>getStringList(MediaType type){
    List<String>items=[];
    for(var item in uploadedImagesLinks){
      if(item.type==type){
        items.add(item.path);
      }
    }
    return items;
  }

  Future<void> initVideo(int index)async{
    print(index);
    await videoPlayerController.dispose();
    videoPlayerController=VideoPlayerController.file(File(mediaPaths[index].path));
    await videoPlayerController.initialize();
    chewieController=ChewieController(videoPlayerController: videoPlayerController,autoPlay: false,);
    emit(AddMediaToPostState());
    emit(InitVideoState());
  }
  void getVideo(ImageSource source)async{
    picker.pickVideo(source: source).then((value){
      if(value!=null){
        mediaPaths.add(MediaPathWithType(path: value.path, type: MediaType.video));
        emit(AddMediaToPostState());
      }
    });
  }

  void onChangePageInPreview(int index){
    if(mediaPaths[index].type==MediaType.video){
      initVideo(index);
    }
  }
}
