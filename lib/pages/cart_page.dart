import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/counter.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../provide/cart.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<String> testList = [];
  @override
  Widget build(BuildContext context) {
    _show();
    return Container(
        child: Column(
      children: <Widget>[
        Container(
          height: 500,
          child: ListView.builder(
            itemCount: testList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(testList[index]),
              );
            },
          ),
        ),
        RaisedButton(
          onPressed: () {
            _add();
          },
          child: Text('add'),
        ),
        RaisedButton(
          onPressed: () {
            _clear();
          },
          child: Text('clear'),
        ),
      ],
    ));
  }

  void _add() async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // String temp = 'Simon';
    // testList.add(temp);
    // preferences.setStringList('testInfo', testList);

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var cartString = preferences.getString(cartKey);
    var temp = cartString == null ? [] : json.decode(cartString.toString());

    List<Map> tempList = (temp as List).cast();

    int ival = 0;

    tempList.forEach((item) {
      tempList[ival]['count'] = item['count'] + 1;
      testList.add(tempList[ival]['goodsName']);
      ival++;
      preferences.setStringList('testInfo', testList);
    });

    _show();
  }

  void _show() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      String temp = preferences.getString('cartKey');
      if (temp != null) {
        testList.add(temp);
      }
    });
  }

  void _clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.clear(); //全部清空
    prefs.remove('testInfo'); //删除key键
    setState(() {
      testList = [];
    });
  }
}

class CartPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Number(), MyButton()],
      )),
    );
  }
}

class Number extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 40),
        child: Provide<Counter>(
          builder: (context, child, counter) {
            return Text('${counter.value}');
          },
        ));
  }
}

class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentCounter = Provide.value<Counter>(context);
    return Container(
      child: RaisedButton(
        onPressed: () {
          currentCounter.increment();
          Fluttertoast.showToast(
              msg: 'click increment button',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.pink,
              textColor: Colors.white,
              fontSize: 16);
        },
        child: Text('递增'),
      ),
    );
  }
}
