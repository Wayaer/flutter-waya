import 'dart:convert';import 'dart:io';import 'package:cookie_jar/cookie_jar.dart';import 'package:dio/dio.dart';import 'package:flutter_waya/src/constant/constant.dart';import 'package:flutter_waya/src/model/ResponseModel.dart';class InterceptorWrap extends InterceptorsWrapper {  final CookieJar cookieJar;  final ResponseModel responseModel = ResponseModel();  InterceptorWrap(this.cookieJar);  @override  Future onRequest(RequestOptions options) async {    if (cookieJar != null) {      var cookies = cookieJar?.loadForRequest(options.uri);      cookies.removeWhere((cookie) {        if (cookie.expires != null) {          return cookie.expires.isBefore(DateTime.now());        }        return false;      });      String cookie = getCookies(cookies);      if (cookie.isNotEmpty) options.headers[HttpHeaders.cookieHeader] = cookie;    }    /// 在请求被发送之前做一些事情 /// 如果你想完成请求并返回一些自定义数据，可以返回一个`Response`对象或返回`dio.resolve(data)`。 /// 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义数据data. /// /// 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象，或返回`dio.reject(errMsg)`， /// 这样请求将被中止并触发异常，上层catchError会被调用。 return options;  }  @override  Future onResponse(Response response) async {    if (cookieJar != null) {      saveCookies(response, responseModel);    }    responseModel.statusCode = response.statusCode;    if (response.statusCode == 200) {      responseModel.statusMessage = 'success';      responseModel.statusMessageT = 'success';      if (response.data is Map || jsonDecode(response.data) is Map) {        responseModel.data = response.data;        return responseModel.toMap();      } else {        responseModel.data = response.data;        return responseModel.toMap();      }    } else {      responseModel.statusCode = response.statusCode;      responseModel.statusMessage = response.statusMessage;      responseModel.statusMessageT = response.statusMessage;      return responseModel;    }  }  @override  Future onError(DioError e) async {    responseModel.type = e.type.toString();    if (e.type == DioErrorType.DEFAULT) {      responseModel.statusCode = ConstConstant.errorCode404;      responseModel.statusMessage = ConstConstant.errorMessage404;      responseModel.statusMessageT = ConstConstant.errorMessageT404;    } else if (e.type == DioErrorType.CANCEL) {      responseModel.statusCode = ConstConstant.errorCode420;      responseModel.statusMessage = ConstConstant.errorMessage420;      responseModel.statusMessageT = ConstConstant.errorMessageT420;    } else if (e.type == DioErrorType.CONNECT_TIMEOUT) {      responseModel.statusCode = ConstConstant.errorCode408;      responseModel.statusMessage = ConstConstant.errorMessage408;      responseModel.statusMessageT = ConstConstant.errorMessageT408;    } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {      responseModel.statusCode = ConstConstant.errorCode502;      responseModel.statusMessage = ConstConstant.errorMessage502;      responseModel.statusMessageT = ConstConstant.errorMessageT502;    } else if (e.type == DioErrorType.SEND_TIMEOUT) {      responseModel.statusCode = ConstConstant.errorCode450;      responseModel.statusMessage = ConstConstant.errorMessage450;      responseModel.statusMessageT = ConstConstant.errorMessageT450;    } else if (e.type == DioErrorType.RESPONSE) {      responseModel.statusCode = e.response.statusCode;      responseModel.statusMessage =          ConstConstant.errorMessage500 + e.response.statusCode.toString();      responseModel.statusMessageT = ConstConstant.errorMessageT500;    }    return jsonEncode(responseModel.toMap());  }  saveCookies(Response response, ResponseModel responseModel) {    if (response != null && response.headers != null) {      List<String> cookies = response.headers[HttpHeaders.setCookieHeader];      responseModel.cookie = cookies;      if (cookies != null) {        cookieJar.saveFromResponse(          response.request.uri,          cookies.map((str) => Cookie.fromSetCookieValue(str)).toList(),        );      }    }  }  static String getCookies(List<Cookie> cookies) {    return cookies.map((cookie) => "${cookie.name}=${cookie.value}").join('; ');  }}