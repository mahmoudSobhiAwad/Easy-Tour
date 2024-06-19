abstract class GetTicketsStates{}

class InitialGetTicketsState extends GetTicketsStates {}

class ChangeEnableReturnDateState extends GetTicketsStates {}

class ChangeOriginReturnCodeState extends GetTicketsStates {}

class ChangeAdultOrChildNumState extends GetTicketsStates {}

class LoadingGetTicketsState extends GetTicketsStates {}

class SuccessGetTicketsState extends GetTicketsStates {}

class FailureGetTicketsState extends GetTicketsStates {
  final String?errMessage;
  FailureGetTicketsState({this.errMessage});
}

class LoadingGetIatCodesState extends GetTicketsStates {}

class SuccessGetIatCodesState extends GetTicketsStates {}

class FailureGetIatCodesState extends GetTicketsStates {
  final String? errMessage;
  FailureGetIatCodesState({this.errMessage});
}

class LoadingGetAccessTokenState extends GetTicketsStates {}

class SuccessGetAccessTokenState extends GetTicketsStates {}

class FailureGetAccessTokenState extends GetTicketsStates {
  final String? errMessage;
  FailureGetAccessTokenState({this.errMessage});
}

