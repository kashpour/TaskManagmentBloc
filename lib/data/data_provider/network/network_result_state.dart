class NetworkResultState {}

class SuccessState extends NetworkResultState {
  final dynamic data;

  SuccessState({required this.data});
}

class FailureState extends NetworkResultState {
  final String errorMessage;

  FailureState({required this.errorMessage});
}
