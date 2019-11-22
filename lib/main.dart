import 'package:flutter/material.dart';
import './model/user.dart';
import './pages/login_animation_page.dart';
import './pages/home.dart'; //登录后的主界面
import './utils/data_utils.dart';

import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';

/// If the current platform is desktop, override the default platform to
/// a supported platform (iOS for macOS, Android for Linux and Windows).
/// Otherwise, do nothing.
void _setTargetPlatformForDesktop() {
  TargetPlatform targetPlatform;
  if (Platform.isMacOS) {
    targetPlatform = TargetPlatform.iOS;
  } else if (Platform.isLinux || Platform.isWindows) {
    targetPlatform = TargetPlatform.android;
  }
  if (targetPlatform != null) {
    debugDefaultTargetPlatformOverride = targetPlatform;
  }
}

//登录前的界面引导
void main(){
  _setTargetPlatformForDesktop();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _hasLogin = false;  //登录
  bool _isLoading = true; //欢迎页
  UserInformation _userInfo;
  int themeColor = 0xFFC91B3A;

  @override
  void initState() {
    super.initState();

//  初始化本地数据库
//  初始化推送
  }

  showWelcomePage() {
    //todo  如果是第一次登陆推出欢迎页
    //  通过本地缓存的token判断，如果已经登陆过，则直接进入主页
    DataUtils.checkLogin().then((_hasLogin){
      // 判断是否已经登录
      if (_hasLogin) {
        return AppHome(null);
      } else {
        return LoginAnimationPage();
      }
    });
    }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      home: showWelcomePage(),
//      home:Scaffold(
//        body: LoginPage(),
//      ),

    );
  }
}