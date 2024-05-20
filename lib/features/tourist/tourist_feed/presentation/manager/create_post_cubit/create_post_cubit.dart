import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:prepare_project/core/utilities/function/set_app_state.dart';
import 'package:prepare_project/features/tourist/tourist_feed/data/model/post_model.dart';
import 'package:prepare_project/features/tourist/tourist_feed/presentation/manager/create_post_cubit/create_post_states.dart';

class CreatePostCubit extends Cubit<CreatePostStates>{
  CreatePostCubit():super(InitialCreatePostState());
  ImagePicker picker=ImagePicker();
  List<String>imagePaths=[];
  List<String>uploadedImagesLinks=[];
  final TextEditingController controller=TextEditingController();
  String sourceEmail=SetAppState.prefs?.getString('email')??"";
  String role=SetAppState.prefs?.getString('role')??"";
  String name=SetAppState.prefs?.getString('name')??"";
  final storageRef = FirebaseStorage.instance.ref('post');
  final db = FirebaseFirestore.instance;
  int userPostNum=0;
  void getImageFromCamera()async{
    XFile? pickedImage;
   await picker.pickImage(source: ImageSource.camera).then((value) {
       pickedImage=value;
    });
    if(pickedImage!=null){
      imagePaths.add(pickedImage!.path);
      emit(AddImagesToPostState());
    }

  }
  void getImagesFromGallery()async{
    await picker.pickMultiImage().then((value) {
      for(var item in value){
         imagePaths.add(item.path);
       }
      emit(AddImagesToPostState());
    });
  }
  void removeSpecificImage(int index){
    imagePaths.removeAt(index);
    emit(RemoveSelectedImageState());
  }

  Future<void>uploadFileToFireBase()async{
    emit(LoadingUploadImagesState());
    for(var item in imagePaths){
      var fileName=basename(item);
      var imageRef=storageRef.child(sourceEmail).child('${DateTime.now().millisecondsSinceEpoch}_$fileName');
      File file=File(item);
      try {
        await imageRef.putFile(file);
        String url=await imageRef.getDownloadURL();
        uploadedImagesLinks.add(url);
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
        postImages:uploadedImagesLinks,
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
    if(imagePaths.isNotEmpty){
      await uploadFileToFireBase().then((value)async {
        if(uploadedImagesLinks.isNotEmpty){
          await createPost();
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
}