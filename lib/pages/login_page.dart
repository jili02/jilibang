import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/data_utils.dart';
import '../model/user.dart';
import '../pages/home.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

//  then 方法来源于 javascript
  doLogin() {
    DataUtils.doLogin({
      'user_name': usernameController.text,
      'user_psw_hash': passwordController.text,
      'token': ''
    }).then((userResult) {
//      runtimeType获取变量的类型
      if (userResult.runtimeType == UserInformation) {
//        登录后先跳转到 主导航 页面
//      route == null 用于隐藏 返回上级页面 按钮
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => AppHome(userResult)),
            (route) => route == null);
      } else {
        Fluttertoast.showToast(
            msg: '验证失败：' + userResult,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Theme.of(context).primaryColor,
            timeInSecForIos: 1,
            textColor: Colors.yellow,
            fontSize: 16.0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //防止输入法软键盘导致出错
      resizeToAvoidBottomPadding: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          //LOGO，展示
          Expanded(
            flex: 3,
            child: //            系统名称,LOGO
                Container(
              width: 200.0,
              height: 200.0,
              margin: const EdgeInsets.only(top: 50, bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    image: AssetImage('lib/images/fighting.jpg'),
                    fit: BoxFit.cover),
//                 DecorationImage(image:  Image.asset('images/fighting.jpg'), fit: BoxFit.cover),
                shape: BoxShape.circle,
              ),
            ),
          ),
          //用户名、密码输入框、登陆按钮
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  //用户名
                  TextField(
                    autocorrect: false,
                    autofocus: false,
                    enabled: true,
                    obscureText: false,
                    maxLengthEnforced: true,
                    controller: usernameController,
                    onChanged: (value) {},
                    onSubmitted: (value) {},
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                        labelText: '邮箱/手机号/账号',
                        border: OutlineInputBorder(),
                        hintText: '请输入邮箱/手机号/账号',
                        prefixIcon: Icon(Icons.person)),
                  ),
                  //密码
                  Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: TextField(
                      enabled: true,
                      obscureText: true,
                      controller: passwordController,
                      onChanged: (value) {},
                      onSubmitted: (value) {},
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                          labelText: '密码',
                          border: OutlineInputBorder(),
                          hintText: '请输入密码',
                          prefixIcon: Icon(Icons.verified_user)),
                    ),
                  ),
                  //登录
                  Container(
                    width: 200,
                    height: 40,
                    padding: EdgeInsets.only(top: 5),
                    child: RaisedButton(
                      onPressed: () {
                        doLogin();
                      },
//                          () {
//                        Navigator.of(context).pushAndRemoveUntil(
//                             MaterialPageRoute(builder: (context) =>  SupplierPage()
//                            ), (route) => route == null);
//                      },
                      color: Colors.blue,
                      textColor: Colors.white,
                      child: Text('登录'),
                    ),
                  )
                ],
              ),
            ),
          ),
          //copyright
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text('©2019 com.jili.bang'),
            ),
          ),
        ],
      ),
    );
  }
}
