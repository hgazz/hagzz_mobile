import 'package:bookit/core/helper/cach/cached_variables.dart';
import 'package:bookit/core/helper/dio/end_points.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: EndPoints.baseUrl,
      receiveDataWhenStatusError: true,
      followRedirects: false,
      validateStatus: (status) => true,
    ));
    if (kDebugMode) {
      dio.interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90));
    }
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    try {
      dio.options.headers = {
        'Authorization': 'Bearer $token',
        "Accept": "application/json",
        "lang": lang,
        if (token != null) 'fcm-token': await CachedVariables.fcmToken
      };
      return await dio.get(url,
          queryParameters: query,
          options: Options(
            validateStatus: (_) => true,
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ));
    } catch (error) {
      rethrow;
    }
  }

  static Future<Response> postData(
      {required String url,
      Map<String, dynamic>? query,
      dynamic data,
      String lang = 'en',
      String? token,
      Map<String, dynamic>? headers,
      CancelToken? cancelToken}) async {
    try {
      dio.options.headers = headers ??
          {
            'Authorization': 'Bearer $token',
            if (token != null) 'fcm-token': await CachedVariables.fcmToken,
            "Accept": "application/json",
            "Content-Type": "application/json",
          };
      return await dio.post(url,
          queryParameters: query,
          data: data,
          cancelToken: cancelToken,
          options: Options(
            validateStatus: (_) => true,
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ));
    } catch (error) {
      rethrow;
    }
  }

  static Future<Response> putData({
    required String url,
    dynamic? data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    try {
      dio.options.headers = {
        'Authorization': 'Bearer $token',
      };
      Response response = await dio.put(
        url,
        data: data,
        queryParameters: query,
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }

  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
    dynamic data,
    String lang = 'en',
    String? token,
  }) async {
    try {
      dio.options.headers = {
        'Authorization': '$token',
        "Accept": "application/json",
        "Content-Type": "application/json",
      };
      final response =
          await dio.delete(url, queryParameters: query, data: data);

      return response;
    } catch (error) {
      rethrow;
    }
  }
}
