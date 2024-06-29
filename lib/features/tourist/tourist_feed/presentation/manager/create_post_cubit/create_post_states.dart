abstract class CreatePostStates{}
class InitialCreatePostState extends CreatePostStates {}
class AddMediaToPostState extends CreatePostStates {}
class RemoveSelectedMediaState extends CreatePostStates {}
class LoadingUploadImagesState extends CreatePostStates {}
class SuccessUploadImagesState extends CreatePostStates {}
class FailureUploadImagesState extends CreatePostStates {
  final String?errMessage;
  FailureUploadImagesState({this.errMessage});
}
class LoadingUploadPostState extends CreatePostStates {}
class SuccessUploadPostState extends CreatePostStates {}

class FailureUploadPostState extends CreatePostStates {
  final String?errMessage;
  FailureUploadPostState({this.errMessage});
}
class FailureGetLengthOfCollectionState extends CreatePostStates {
  final String?errMessage;
  FailureGetLengthOfCollectionState({this.errMessage});
}
class SuccessGetLengthOfCollectionState extends CreatePostStates {}

class InitVideoState extends CreatePostStates {}

class LoadingFilterPosts extends CreatePostStates {}

class SuccessFilterPosts extends CreatePostStates {}

class FailureFilterPosts extends CreatePostStates {
  final String?errMessage;
  FailureFilterPosts({this.errMessage});
}