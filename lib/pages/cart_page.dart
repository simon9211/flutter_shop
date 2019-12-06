import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/counter.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../provide/cart.dart';
import 'cart_page/cart_item.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body: FutureBuilder(
        future: _getCartInfo(context),
        builder: (context, snapshot) {
          List cartList = Provide.value<CartProvide>(context).cartList;
          if (snapshot.hasData) {
            return Stack(
              children: <Widget>[
                Provide<CartProvide>(
                  builder: (context, child, model) {
                    cartList = Provide.value<CartProvide>(context).cartList;
                    return ListView.builder(
                      itemCount: cartList.length,
                      itemBuilder: (context, index) {
                        return CartItem(
                          item: cartList[index],
                        );
                        // return ListTile(
                        //   title: Text(cartList[index].goodsName + '${cartList[index].count}'),
                        // );
                      },
                    );
                  },
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: CartBottom(),
                )
              ],
            );
          } else {
            return Text('loading');
          }
        },
      ),
    );
  }

  Future<String> _getCartInfo(BuildContext context) async {
    await Provide.value<CartProvide>(context).getCartInfo();
    return 'end';
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
