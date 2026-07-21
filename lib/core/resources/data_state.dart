//return a single type (DataState<T>)
// instead of throwing exceptions directly to the presentation layer.
import 'package:dio/dio.dart';

class DataState<T> {
  const DataState({this.data, this.error});

  final T? data; //t means generic type
  final DioException? error;
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(DioException error) : super(error: error);
}
