import 'package:flutter/material.dart';
import '../model/user.dart';
import '../pages/supplier_page.dart';
import '../pages/product_page.dart';
import '../pages/login_page.dart';
import '../pages/datagrid_page.dart';
import 'login_animation_page.dart';

//系统主要界面结构
//主导航，索引
class AppHome extends StatefulWidget {
  final UserInformation userInfo;

//通过构造函数增加参数，可以接收外部页面传来的数据
  AppHome(this.userInfo);

  @override
  _AppHomeState createState() => _AppHomeState();
}

//如果需要有动画效果，则需要widget继承 SingleTickerProviderStateMixin
//class StartState extends State<Start> with SingleTickerProviderStateMixin
class _AppHomeState extends State<AppHome> {
  //当前中部内容序号，    基本页面框架为顶部标题，中部内容，底部导航，此处记录中部内容widget的序号
  int _currentMiddleWidgetIndex = 0;

//  顶部标题的集合，和底部导航对应
  List _topTabList = [
    {'text': 'supplier', 'icon': Icon(Icons.people)},
    {'text': 'product', 'icon': Icon(Icons.store)},
    {'text': 'DataGrid','icon': Icon(Icons.grid_on)}
  ];

//  中部内容的widget集合
  List<Widget> _middleWidgetList = List();


//  底部导航的集合
  List<BottomNavigationBarItem> _bottomTabList = [];


//  重写widget初始化
  @override
  void initState() {
    super.initState();
//    顶部

//    中部
//    中部要显示内容初始化
    _middleWidgetList.add(SupplierPage());
    _middleWidgetList.add(ProductPage());
    _middleWidgetList.add(DataGridTest());

//    底部
//   给底部导航列表初始化
    _bottomTabList.add(BottomNavigationBarItem(
      icon: Icon(Icons.people),
      title: Text('supplier'),
    ));
    _bottomTabList.add(BottomNavigationBarItem(
      icon: Icon(Icons.store),
      title: Text('product'),
    ));
    _bottomTabList.add(BottomNavigationBarItem(
      icon: Icon(Icons.grid_on),
      title: Text('DataGrid'),
    ));
  }

//  更新状态，更新当前点击的索引号
  void _bottomTabTapped(int index){
    setState(() {
      _currentMiddleWidgetIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //防止输入法软键盘导致出错
      resizeToAvoidBottomPadding: false,
      //抽屉
      drawer: _drawer(context),
      //顶部Bar
      appBar: AppBar(
        //leading在抽屉的位置，默认显示返回上一页箭头，可以设置新图标
//          leading:,
        title: Text(_topTabList[_currentMiddleWidgetIndex]['text']),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            tooltip: '查询',
            onPressed: () {
              //todo supplier查询
            },
          )
        ],
        //功能按钮
      ),
//      中部内容，通过IndexedStack实现 中间部分动态显示
      body: IndexedStack(
        index: _currentMiddleWidgetIndex,
        children: _middleWidgetList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomTabList,
        currentIndex: _currentMiddleWidgetIndex,
//        底部导航被点击的事件
        onTap: _bottomTabTapped,
      ),

    );
  }
}

Drawer _drawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.lightBlueAccent,
          ),
          child: Center(
            child: SizedBox(
              width: 60.0,
              height: 60.0,
              child: CircleAvatar(
                child: Text('头像'),
              ),
            ),
          ),
        ),
        ListTile(
          title: Text('LoginPage'),
          leading: CircleAvatar(
            child: Icon(Icons.school),
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return LoginAnimationPage();
            }));
          },
        ),
        ListTile(
          title: Text('Item 2'),
          leading: CircleAvatar(
            child: Text('B2'),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('Item 3'),
          leading: CircleAvatar(
            child: Icon(Icons.list),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
