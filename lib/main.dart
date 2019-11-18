import 'package:flutter/material.dart';
import './model/user.dart';
import './pages/login_page.dart';
import './pages/login_animation_page.dart';

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

void main(){
  _setTargetPlatformForDesktop();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _hasLogin = false;
  bool _isLoading = true;
  UserInformation _userInfo;
  int themeColor = 0xFFC91B3A;

  @override
  void initState() {
    super.initState();

//  初始化本地数据库
//  初始化推送
//  如果是第一次登陆推出欢迎页
//  如果已经登陆过，且token有效则直接进入主页
//
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      home: LoginAnimationPage(),
//      home:Scaffold(
//        body: LoginPage(),
//      ),

    );
  }
}