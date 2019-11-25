import 'dart:async' show Future;
import 'dart:io';

import './net_utils.dart';
import '../model/user.dart';
import '../api/api.dart';
import '../model/version.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DataUtils {
//  用户注册
  static Future RegUser(Map<String,dynamic> params) async {
//        print('RegUser============='+params['user_name']);
//        print('RegUser============='+params['user_psw_hash']);

    var response = await NetUtils.post(Api.REG_USER, params);
    try {
      if (response['success']) { return null;} else {return response['message'];}

    } catch (err) {
      return response['message'];
    }
  }


  // 登陆获取用户信息
  static Future doLogin(Map<String, String> params) async {
//    print('doLogin============='+Api.DO_LOGIN);
    var response = await NetUtils.post(Api.DO_LOGIN, params);
    try {
      if (response['success']) {
        UserInformation userInfo = UserInformation.fromJson(response['data']);

        //  登录成功，把token记录下来
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('user_id', userInfo.userId.toString());
        preferences.setString('user_name', userInfo.userName);
        preferences.setString('token',response['token']);

        return userInfo;
      } else {
        return response['message'];
      }
    } catch (err) {
      return response['message'];
    }
  }

  // 获取用户信息
  static Future<UserInformation> getUserInfo(Map<String, String> params) async {
    var response = await NetUtils.get(Api.GET_USER_INFO, params);
    try {
      UserInformation userInfo = UserInformation.fromJson(response['data']);
      return userInfo;
    } catch (err) {
      return response['message'];
    }
  }

  // 验证登陆
  static Future<bool> checkLogin() async {
//    看看本地文件有没有token
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var localToken = preferences.getString('token');
    if ((localToken == '') || (localToken == null)) {
      return false;
    }

    print(Api.CHECK_LOGIN + '  =================== ''token'': ''$localToken''');
//  拿token去验证
    var response = await NetUtils.post(Api.CHECK_LOGIN,{'token':localToken});
    print('===============================================response: $response');
    try {
      if (response['success']) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      return false;
    }
  }

  // 退出登陆
  static Future<bool> logout() async {
    var response = await NetUtils.get(Api.LOGOUT);
    print('退出登陆 $response');
    return response['success'];
  }

  // 检查版本
  static Future<bool> checkVersion(Map<String, String> params) async {
    var response = await NetUtils.get(Api.VERSION, params);
    Version version = Version.formJson(response);
    var currVersion = version.data.version;
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    var localVersion = packageInfo.version;
    //相同=0、大于=1、小于=-1
    //    localVersion = '0.0.2';
    //    currVersion = '1.0.6';
    if (currVersion.compareTo(localVersion) == 1) {
      return true;
    } else {
      return false;
    }
  }
}
