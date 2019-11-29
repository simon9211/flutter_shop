import 'package:flutter/material.dart';

class CategoryGoodsListProvide with ChangeNotifier {
  List<Map> _goodsList = [];

  List<Map> get goodsList => _goodsList;

  // 更换商品列表
  void getGoodsList(List<Map> list) {
    _goodsList = list;
  }

}