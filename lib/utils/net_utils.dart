import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

Map<String, dynamic> optHeader = {
//  HttpHeaders.userAgentHeader: 'dio',
//  HttpHeaders.acceptCharsetHeader
//  'content-type': 'application/json;charset=UTF-8',
//  'Accept': 'application/json',
};

var dio = new Dio(BaseOptions(connectTimeout: 30000));

class NetUtils {
  static Future get(String url, [Map<String, dynamic> params]) async {
    var response;
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String documentsPath = documentsDir.path;
    var dir = new Directory("$documentsPath/cookies");
    await dir.create();

    dio.interceptors.add(CookieManager(PersistCookieJar(dir: dir.path)));
//    dio.interceptors.add(PersistCookieJar(dir: dir.path));

    if (params != null) {
      response = await dio.get(url, queryParameters: params);
    } else {
      response = await dio.get(url);
    }
//    print('NetUtils.get:========================================');
//    print(response.data['objects'].length);
//    print('NetUtils.get:========================================');
    return response.data;
  }

  static Future post(String url, Map<String, dynamic> params) async {
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String documentsPath = documentsDir.path;
    var dir = new Directory("$documentsPath/cookies");
    await dir.create();
//    dio.interceptors.add(CookieManager(PersistCookieJar(dir: dir.path)));
    print(url);
    print(params['user_name'].toString());
    print(params['user_psw_hash'].toString());

    var response = await dio.post(url, data: params);
//    print('post:======='+response.data['message']);
    return response.data;

  }
}