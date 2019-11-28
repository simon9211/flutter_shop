import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/counter.dart';

class CartPage extends StatelessWidget {
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
        },
        child: Text('递增'),
      ),
    );
  }
}
