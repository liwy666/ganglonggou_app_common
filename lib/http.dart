import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'common_import.dart';

Dio dio = new Dio();

//初始化Http
void initHttp() {
  //配置
  dio.options.receiveTimeout = 5000; //超时时间ms
  //dio.options.baseUrl = 'https://api.ganglonggou.com/api/v1';
  dio.options.baseUrl = 'https://test-api.ganglonggou.com/api/v1';
  //拦截器
  dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options) {
    // 在请求被发送之前做一些事情
    return options; //continue
    // 如果你想完成请求并返回一些自定义数据，可以返回一个`Response`对象或返回`dio.resolve(data)`。
    // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义数据data.
    //
    // 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象，或返回`dio.reject(errMsg)`，
    // 这样请求将被中止并触发异常，上层catchError会被调用。
  }, onResponse: (Response response) {
    // 在返回响应数据之前做一些预处理
    if (response.data is Map) {
      if (response.data.containsKey('error_code')) {
        //打印错误
        Fluttertoast.showToast(msg: response.data['msg']); //短提示
        throw Exception(response.data['msg']); //continue
      }
    }
    return response; // continue
  }, onError: (DioError e) {
    Fluttertoast.showToast(msg: "未知错误${e.toString()}",timeInSecForIos:3); //短提示
    // 当请求失败时做一些预处理
    throw Exception(e); //continue
  }));
}

