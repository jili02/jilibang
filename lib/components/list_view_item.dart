import 'package:flutter/material.dart';
import 'package:jilibang/model/supplier.dart';
import '../routers/application.dart';
import 'dart:core';


class ListViewItem extends StatelessWidget {
  SupplierData itemss;

  ListViewItem(this.itemss);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: ListTile(
        onTap: () {
          //router
        },
        title: Padding(
          child: Text(
            itemss.supplier_shorter,
            style: TextStyle(color: Colors.black, fontSize: 15.0),
          ),
          padding: EdgeInsets.only(top: 10.0),
        ),
        subtitle: Row(
          children: <Widget>[
            Padding(
              child: Text(itemss.supplier_id,
                  style: TextStyle(color: Colors.black54, fontSize: 10.0)),
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            ),
            Padding(
              child: Text(itemss.supplier_linkman,
                  style: TextStyle(color: Colors.black54, fontSize: 10.0)),
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            ),
            Padding(
              child: Text(itemss.supplier_telphone,
                  style: TextStyle(color: Colors.black54, fontSize: 10.0)),
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            )
          ],
        ),
      ),
    );
  }
}