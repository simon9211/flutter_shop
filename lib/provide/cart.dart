import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final String cartKey = 'cartInfo';

class CartProvide with ChangeNotifier {
  String cartString = '[]';


  void save(goodsId, goodsName, count, price, images) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    cartString = preferences.getString(cartKey);
    var temp = cartString == null?[]:json.decode(cartString.toString());

    List<Map> tempList = (temp as List).cast();

    var isHave = false;
    int ival = 0;

    tempList.forEach((item){
      if (item['goodsId'] == goodsId) {
        tempList[ival]['count'] = item['count'] + 1;
        isHave = true;
      }
      ival++;
    });

    if (!isHave) {
      tempList.add({
        'goodsId':goodsId,
        'goodsName':goodsName,
        'count':count,
        'price':price,
        'images':images
      });
    }

    cartString= json.encode(tempList).toString();
    print(cartString);
    preferences.setString(cartKey, cartString);//进行持久化
  }


  void remove() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(cartKey);
    notifyListeners();
  }
}