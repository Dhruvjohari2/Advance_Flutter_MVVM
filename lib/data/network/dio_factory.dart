import 'dart:convert';

import 'package:advance_mvvm/app/app_prefs.dart';
import 'package:advance_mvvm/app/constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "language";

class Diofactory {
  AppPreferences _appPreferences;

  Diofactory(this._appPreferences);


  Future<Dio> getDio() async {
    Dio dio = Dio();
    int _timeOut = 60 * 1000;
    // String language = await _appPreferences.getAppLanguage();
    Map<String, dynamic> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORIZATION: Constant.token,
      // DEFAULT_LANGUAGE: language,
    };
    dio.options = BaseOptions(
      baseUrl: Constant.baseUrl,
      connectTimeout: Duration(minutes: _timeOut),
      receiveTimeout: Duration(minutes: _timeOut),
      headers: headers,
    );
    print("dio : $dio");
    if (kReleaseMode) {
      print("release mode no logs");
    } else {
      print("Errror1 ${Response}");
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (RequestOptions options,RequestInterceptorHandler handler) {
            return handler.next(options);
          },
          onResponse: (Response response, ResponseInterceptorHandler handler){
            if(response.data is String ){
              try {
                final jsonData = jsonDecode(response.data);
                response.data = jsonData;
              } on FormatException catch (e) {
                print("Error prasing JSON: $e");
              }
            }
            else {
      print("Errror3");
              print('REspinse data is likely  JSON');
            }
            return handler.next(response);
          },
          onError: (DioException error, ErrorInterceptorHandler handler){
            print("Errror4 ${Response}");
            return handler.next(error);
      }
        )
      );
    }
    return dio;
  }
}
