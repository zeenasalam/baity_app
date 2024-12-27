sealed class ResultState<T> {}

class Loading<T> extends ResultState<T> {}

class Idle<T> extends ResultState<T> {}

class Error<T> extends ResultState<T> {
  final String error;

  Error(this.error);
}

class Data<T> extends ResultState<T> {
  final T data;

  Data(this.data);
}
