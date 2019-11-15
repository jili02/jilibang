import 'package:flutter/material.dart';
import 'package:json_table/json_table.dart';
import 'package:json_table/json_table_column.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
//订单号	创建时间	产品名称	产品单价	产品数量	合计	产品条形码	产品单位	制单人	备注	客户名称	客户地址	客户电话	UserGUID

class DataGridTest extends StatefulWidget {
  @override
  _DataGridTestState createState() => _DataGridTestState();
}

class _DataGridTestState extends State<DataGridTest> {
  final String jsonSample =
      '[{"name":"Ram","email":{"1":"ram@gmail.com"},"age":23,"DOB":"1990-12-01"},'
      '{"name":"Shyam","email":{"1":"shyam23@gmail.com"},"age":18,"DOB":"1995-07-01"},'
      '{"name":"John","email":{"1":"john@gmail.com"},"age":10,"DOB":"2000-02-24"}]';
  bool toggle = true;
  List<JsonTableColumn> columns;

  String getPrettyJSONString(jsonObject) {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String jsonString = encoder.convert(json.decode(jsonObject));
    return jsonString;
  }

  String formatDOB(value) {
    var dateTime = DateFormat("yyyy-MM-dd").parse(value.toString());
    return DateFormat("d MMM yyyy").format(dateTime);
  }

  String eligibleToVote(value) {
    if (value >= 18) {
      return "Yes";
    } else
      return "No";
  }

  @override
  void initState() {
    super.initState();
    columns = [
      JsonTableColumn("name", label: "Name"),
      JsonTableColumn("age", label: "Age"),
      JsonTableColumn("DOB", label: "Date of Birth", valueBuilder: formatDOB),
      JsonTableColumn("age",
          label: "Eligible to Vote", valueBuilder: eligibleToVote),
      JsonTableColumn("email.1", label: "E-mail", defaultValue: "NA"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var json = jsonDecode(jsonSample);

    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            JsonTable(json, columns: columns, showColumnToggle: true),
            SizedBox(
              height: 16.0,
            ),
            Text(
              getPrettyJSONString(jsonSample),
              style: TextStyle(fontSize: 13.0),
            ),

          ],

        ),
      ],
    );
  }
}
