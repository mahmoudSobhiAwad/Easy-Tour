abstract class ViewPostStates{}
class InitialViewPostState extends ViewPostStates {}
class LoadingGetPostsState extends ViewPostStates {}
class SuccessGetPostsState extends ViewPostStates {}
class FailureGetPostsState extends ViewPostStates {
  final String?errMessage;
  FailureGetPostsState({this.errMessage});
}