import 'package:flutter/material.dart';

import '../utils/net_utils.dart';

import '../model/supplier.dart';
import '../components/list_refresh.dart';
import '../components/list_view_item.dart';

//联系人	简称	供货商编号	通信地址	邮政编码	手机	座机	备注1	全称	备注2	所在省份

class SupplierPage extends StatefulWidget {
  @override
  _SupplierPageState createState() => _SupplierPageState();
}

class _SupplierPageState extends State<SupplierPage> {
  Future<Map> getIndexListData([Map<String, dynamic> params]) async {
//    print('params=================================');
//    print(params);
//    print('params=================================');
    //后台API
    const supplier_jilibang = 'http://154.8.219.198/api/t_supplier';
    var pageIndex = (params.isNotEmpty) ? params['pageIndex'] : 1;
    var responseList = [];
    var pageTotal = 0;
    pageIndex += 1;
    final _param = {'page': pageIndex};
//    print('_param=================================');
//    print(_param);
//    print('_param=================================');
    try {
      var response = await NetUtils.get(supplier_jilibang, _param);
      responseList = response['objects']; //JSON中存储数据的位置
      pageTotal = response['total_pages'];
      if (!(pageTotal is int) || pageTotal <= 0) {
        pageTotal = 0;
      }
    } catch (e) {}

    List resultList = List();
    for (int i = 0; i < responseList.length; i++) {
      try {
//        print(responseList[i]);
        //循环JSON中的数据，一次取一条，实例化supplierData 并赋值
        SupplierData cellData = SupplierData.fromJson(responseList[i]);
        //赋值后的实例 装到列表里
        resultList.add(cellData);
      } catch (e) {
        // No specified type, handles all
      }
    }
    Map<String, dynamic> result = {
      "list": resultList,
      'pageTotal': pageTotal,
      'pageIndex': pageIndex
    };
//    print('getIndexListData=================================');
//    print(result);
//    print('getIndexListData=================================');
    return result;
  }

  //每个item的样式
  Widget makeCard(index, item) {
    return ListViewItem(item);
  }

  int currentIndex;

  @override
  void initState(){
    super.initState();
    currentIndex = 0;
  }

  void _changePage(int index){
    if(index != currentIndex) {
      setState(() {
        currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
//   使用 Stack 创建一个页面，在通过主导航界面的IndexedStack实现切换
    return Stack(
      children: <Widget>[
//        以竖向大列表的形式展示
        Column(
          children: <Widget>[
//            自动填充panel
            Expanded(
//             刷新列表
              child: ListRefresh(getIndexListData, makeCard),
            )
          ],
        )
      ],
    );
  }
}
