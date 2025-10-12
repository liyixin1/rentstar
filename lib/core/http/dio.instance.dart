import 'package:dio/dio.dart';
import 'package:rentstar/core/http/http_mothod.dart';
import 'package:rentstar/core/http/interceptor/print_log.dart';

class DioInstance{
  static DioInstance? _instance;

  DioInstance._internal();

  static DioInstance instance(){
    return _instance ??= DioInstance._internal();
  }
  Dio _dio = Dio();
  final _defaultTimeout = const Duration(seconds: 30);
  var _inited = false;

  void initDio({
    required String baseUrl,
    String? method = HttpMethod.GET,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    ResponseType? responseType = ResponseType.json,
    String? contentType
}) async {
    _dio.options = BaseOptions(
      baseUrl: baseUrl,
      method: method,
      connectTimeout: connectTimeout ?? _defaultTimeout,
      receiveTimeout: receiveTimeout ?? _defaultTimeout,
      sendTimeout: sendTimeout ?? _defaultTimeout,
      contentType: contentType
    );
    _dio.interceptors.add(PrintLogInterceptor());
    _inited = true;
  }

  Future<Response> get({
    required String path,
    Map<String,dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken
  }) async {
    if(!_inited){
      throw StateError("未调用initDio初始化。");
    }
    return await _dio.get(
      path,
      queryParameters: queryParameters,
      options: options ??
        Options(
          method: HttpMethod.GET,
          receiveTimeout: _defaultTimeout,
          sendTimeout: _defaultTimeout,
        ),
      cancelToken: cancelToken
    );
  }
  Future<Response> post({
  required String path,
  Object? data,
  Map<String, dynamic>? queryParameters,
  Options? options,
  CancelToken? cancelToken
  }) async {
    if(!_inited){
      throw StateError("未调用initDio初始化。");
    }
    return await _dio.post(path,
    data: data,
    queryParameters: queryParameters,
    cancelToken: cancelToken,
        options: options ??
            Options(
              method: HttpMethod.POST,
              receiveTimeout: _defaultTimeout,
              sendTimeout: _defaultTimeout,
            )
    );
  }
}