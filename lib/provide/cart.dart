import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/cartInfo.dart';

final String cartKey = 'cartInfo';

class CartProvide with ChangeNotifier {
  String cartString = '[]';
  List<CartInfoModel> cartList = [];

  void save(goodsId, goodsName, count, price, images) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    cartString = preferences.getString(cartKey);
    var temp = cartString == null ? [] : json.decode(cartString.toString());

    List<Map> tempList = (temp as List).cast();

    var isHave = false;
    int ival = 0;

    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        tempList[ival]['count'] = item['count'] + 1;
        cartList[ival].count++;
        isHave = true;
      }
      ival++;
    });

    if (!isHave) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images,
        'isCheck': true
      };
      tempList.add(newGoods);
      cartList.add(CartInfoModel.fromJson(newGoods));
    }

    cartString = json.encode(tempList).toString();
    print(cartString);
    preferences.setString(cartKey, cartString); //进行持久化

    notifyListeners();
  }

  void reduce(goodsId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    cartString = preferences.getString(cartKey);
    var temp = cartString == null ? [] : json.decode(cartString.toString());

    List<Map> tempList = (temp as List).cast();

    var isHave = false;
    int ival = 0;

    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        tempList[ival]['count'] = item['count'] - 1;
        cartList[ival].count--;
        isHave = true;
      }
      ival++;
    });

    cartString = json.encode(tempList).toString();
    print(cartString);
    preferences.setString(cartKey, cartString); //进行持久化

    notifyListeners();
  }

// 清空
  void remove() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(cartKey);
    notifyListeners();
  }

  void getCartInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    cartString = preferences.getString(cartKey);
    cartList = [];

    if (cartString != null) {
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
      tempList.forEach((item) {
        cartList.add(CartInfoModel.fromJson(item));
      });
    }

    notifyListeners();
  }

  void deleteGoods(String goodsId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    cartString = preferences.getString(cartKey);
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();

    int tempIndex = 0;
    int delIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        delIndex = tempIndex;
      }
      tempIndex++;
    });

    tempList.removeAt(delIndex);
    cartString = json.encode(tempList).toString();
    preferences.setString(cartKey, cartString);
    await getCartInfo();
  }
}
