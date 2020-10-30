import 'dart:convert';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:flutter_waya/flutter_waya.dart';

//网络链接超时时间
const int HTTP_TIMEOUT_CONNECT = 5000;
//接收超时时间
const int HTTP_TIMEOUT_RECEIVE = 10000;
//请求数据类型 (4种): application/x-www-form-urlencoded 、multipart/form-data、application/json、text/xml
const List<String> HTTP_CONTENT_TYPE = <String>[
  'application/x-www-form-urlencoded',
  'multipart/form-data',
  'application/json',
  'text/xml'
];

class DioTools {
  factory DioTools() => getInstance();

  DioTools._internal({BaseOptions options}) {
    _dio = Dio();
    _initOptions(_dio, options: options);
    _dio.interceptors.add(InterceptorWrap());
  }

  void _initOptions(Dio dio, {BaseOptions options}) {
    if (options == null) return;
    final BaseOptions _options = dio.options;
    _options.connectTimeout = options?.connectTimeout ?? HTTP_TIMEOUT_CONNECT;
    _options.receiveTimeout = options?.receiveTimeout ?? HTTP_TIMEOUT_RECEIVE;
    _options.contentType = options?.contentType ??
        (dio == _dio ? HTTP_CONTENT_TYPE[2] : HTTP_CONTENT_TYPE[1]);
    _options.responseType = options?.responseType ??
        (dio == _dio ? ResponseType.json : ResponseType.plain);
    _options.headers = options?.headers ?? <String, dynamic>{};
  }

  Dio _dio;
  final CancelToken _cancelToken = CancelToken();

  static DioTools _instance;

  static DioTools get instance => getInstance();

  static DioTools getInstance({BaseOptions options}) =>
      _instance ??= DioTools._internal(options: options);

  Future<ResponseModel> getHttp(String url,
      {Map<String, dynamic> params,
      dynamic data,
      CookieJar cookieJar,
      HttpType httpType = HttpType.get,
      BaseOptions options}) async {
    try {
      _initOptions(_dio, options: options);
      log('${httpType.toString()} url:$url  params:${params.toString()}  data:${data.toString()}');
      Response<dynamic> response;
      switch (httpType) {
        case HttpType.get:
          response = await _dio.get<dynamic>(url,
              queryParameters: params, cancelToken: _cancelToken);
          break;
        case HttpType.post:
          response = await _dio.post<dynamic>(url,
              queryParameters: params, data: data, cancelToken: _cancelToken);
          break;
        case HttpType.put:
          response = await _dio.put<dynamic>(url,
              queryParameters: params, data: data, cancelToken: _cancelToken);
          break;
        case HttpType.delete:
          response = await _dio.delete<dynamic>(url,
              queryParameters: params, data: data, cancelToken: _cancelToken);
          break;
        default:
          response = await _dio.get<dynamic>(url,
              queryParameters: params, cancelToken: _cancelToken);
          break;
      }
      if (response == null) return constResponseModel();
      final ResponseModel responseModel = response.data as ResponseModel;
      if (responseModel?.request?.responseType != ResponseType.bytes &&
          responseModel?.request?.responseType != ResponseType.stream) {
        log('$httpType url:$url  responseData==  ${responseModel.toMap().toString()}');
      }
      return responseModel;
    } on DioError catch (e) {
      final ResponseModel errorData =
          ResponseModel.fromJson(jsonDecode(e.message) as Map<String, dynamic>);
      log('error:$url  errorData==  ${errorData.toMap().toString()}');
      return errorData;
    } catch (e) {
      return constResponseModel();
    }
  }

  ResponseModel constResponseModel() => ResponseModel(
      statusCode: 404,
      type: DioErrorType.DEFAULT.toString(),
      statusMessage: ConstConstant.unknownException,
      statusMessageT: ConstConstant.unknownException);

  //下载文件需要申请文件储存权限
  Future<Response<dynamic>> download(
    String url,
    String savePath, {
    ProgressCallback onReceiveProgress,
    BaseOptions options,
  }) async {
    try {
      log('Download url:$url  savePath:${savePath.toString()}');
      final Dio dio = Dio();
      _initOptions(dio, options: options);
      return await dio.download(url, savePath,
          cancelToken: _cancelToken, onReceiveProgress: onReceiveProgress);
    } catch (e) {
      return constResponse();
    }
  }

  ///文件上传
  Future<Response<dynamic>> upload<T>(String url,
      {Map<String, dynamic> params,
      dynamic data,
      BaseOptions options,
      ProgressCallback onSendProgress,
      ProgressCallback onReceiveProgress}) async {
    try {
      log('Upload url:$url  params:${params.toString()}  data:${data.toString()}');
      final Dio dio = Dio();
      _initOptions(dio, options: options);
      return await dio.post<dynamic>(url,
          queryParameters: params,
          data: data,
          cancelToken: _cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress);
    } catch (e) {
      return constResponse();
    }
  }

  Response<dynamic> constResponse() => Response<dynamic>(
      statusCode: 404,
      statusMessage: ConstConstant.unknownException,
      data: null);

  void cancel() => _cancelToken.cancelError;
}

class InterceptorWrap extends InterceptorsWrapper {
  InterceptorWrap();

  CookieJar cookieJar = CookieJar();

  final ResponseModel responseModel = ResponseModel();

  @override
  Future<void> onRequest(RequestOptions options) async {
    /// 在请求被发送之前做一些事情
    /// 如果你想完成请求并返回一些自定义数据，可以返回一个`Response`对象或返回`dio.resolve(data)`。
    /// 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义数据data.
    /// 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象，或返回`dio.reject(errMsg)`，
    /// 这样请求将被中止并触发异常，上层catchError会被调用。 return options;
    if (cookieJar != null) {
      final List<Cookie> cookies = cookieJar?.loadForRequest(options.uri);
      cookies.removeWhere((Cookie cookie) {
        if (cookie.expires != null)
          return cookie.expires.isBefore(DateTime.now());
        return false;
      });
      final String cookie = getCookies(cookies);
      if (cookie.isNotEmpty) options.headers[HttpHeaders.cookieHeader] = cookie;
    }
  }

  void saveCookies(Response<dynamic> response) {
    if (response != null && response.headers != null) {
      final List<String> cookies =
          response.headers[HttpHeaders.setCookieHeader];
      responseModel.cookie = cookies;
      if (cookies != null)
        cookieJar.saveFromResponse(
            response.request.uri,
            cookies
                .map((String str) => Cookie.fromSetCookieValue(str))
                .toList());
    }
  }

  @override
  Future<ResponseModel> onResponse(Response<dynamic> response) async {
    if (cookieJar != null) saveCookies(response);
    if (response.statusCode == 200) {
      responseModel.statusMessage = ConstConstant.success;
      responseModel.statusMessageT = ConstConstant.success;
      responseModel.data = response.data;
    } else {
      responseModel.statusMessage = response.statusMessage;
      responseModel.statusMessageT = response.statusMessage;
    }
    responseModel.statusCode = response?.statusCode;
    responseModel.request = response?.request;
    responseModel.headers = response?.headers;
    responseModel.isRedirect = response?.isRedirect;
    responseModel.redirects = response?.redirects;
    responseModel.extra = response?.extra;
    return responseModel;
  }

  @override
  Future<String> onError(DioError err) async {
    responseModel.type = err.type.toString();
    if (err.type == DioErrorType.DEFAULT) {
      responseModel.statusCode = ConstConstant.errorCode404;
      responseModel.statusMessage = ConstConstant.errorMessage404;
      responseModel.statusMessageT = ConstConstant.errorMessageT404;
    } else if (err.type == DioErrorType.CANCEL) {
      responseModel.statusCode = ConstConstant.errorCode420;
      responseModel.statusMessage = ConstConstant.errorMessage420;
      responseModel.statusMessageT = ConstConstant.errorMessageT420;
    } else if (err.type == DioErrorType.CONNECT_TIMEOUT) {
      responseModel.statusCode = ConstConstant.errorCode408;
      responseModel.statusMessage = ConstConstant.errorMessage408;
      responseModel.statusMessageT = ConstConstant.errorMessageT408;
    } else if (err.type == DioErrorType.RECEIVE_TIMEOUT) {
      responseModel.statusCode = ConstConstant.errorCode502;
      responseModel.statusMessage = ConstConstant.errorMessage502;
      responseModel.statusMessageT = ConstConstant.errorMessageT502;
    } else if (err.type == DioErrorType.SEND_TIMEOUT) {
      responseModel.statusCode = ConstConstant.errorCode450;
      responseModel.statusMessage = ConstConstant.errorMessage450;
      responseModel.statusMessageT = ConstConstant.errorMessageT450;
    } else if (err.type == DioErrorType.RESPONSE) {
      responseModel.statusCode = err.response.statusCode;
      responseModel.statusMessage =
          ConstConstant.errorMessage500 + err.response.statusCode.toString();
      responseModel.statusMessageT = ConstConstant.errorMessageT500;
    }
    responseModel.request = err?.request;
    responseModel.headers = err?.response?.headers;
    responseModel.isRedirect = err?.response?.isRedirect;
    responseModel.redirects = err?.response?.redirects;
    responseModel.extra = err?.response?.extra;
    responseModel.data = null;
    responseModel.cookie = null;
    return responseModel.toJson();
  }

  static String getCookies(List<Cookie> cookies) => cookies
      .map((Cookie cookie) => '${cookie.name}=${cookie.value}')
      .join('; ');
}