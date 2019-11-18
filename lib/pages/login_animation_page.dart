import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

//import 'package:flutter_login/flutter_login.dart';
import '../third_part/flutter_login/lib/flutter_login.dart';

import 'home.dart';
import '../utils/data_utils.dart';
import '../model/user.dart';

// 增加带动画的登录界面
// https://github.com/NearHuscarl/flutter_login

class LoginAnimationPage extends StatelessWidget {
//  动画效果的延迟时间
  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);

  Future<String> _loginUser(LoginData data) {
    return Future.delayed(loginTime).then((_) {
      return DataUtils.doLogin({
        'user_name': data.name,
        'user_psw_hash': data.password,
        'token': ''
      }).then((userResult) {//      runtimeType获取变量的类型
        if (userResult.runtimeType == UserInformation) {
          return null;
        } else
          return userResult;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: '账房先生',
      emailValidator: null,
//      logo: 'lib/images/fighting.jpg',


      onLogin: (loginData) {
        print('Login info');
        print('Name: ${loginData.name}');
        print('Password: ${loginData.password}');
        return _loginUser(loginData);
      },
      onSignup: (_) => Future(null),
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => AppHome(null)),
            (route) => route == null);
      },
      onRecoverPassword: (_) => Future(null),
      messages: LoginMessages(
        usernameHint: '手机号',
        passwordHint: '密码',
        confirmPasswordHint: '确认密码',
        loginButton: '登录',
        signupButton: '注册',
        forgotPasswordButton: '忘记密码?',
        recoverPasswordButton: '恢复密码',
        goBackButton: '返回',
        confirmPasswordError: '两次密码不匹配!',
        recoverPasswordDescription: '请输入手机号，系统会将重置后的密码发送短信给你',
        recoverPasswordSuccess: '密码重置成功',
      ),
    );
  }
}
