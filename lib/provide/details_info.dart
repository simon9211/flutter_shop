import 'package:flutter/material.dart';
import '../model/detail.dart';
import '../service/service_method.dart';

class DetailsInfoProvide with ChangeNotifier {
  GoodsDetailModel _goodsDetailModel;

  GoodsDetailModel get goodsDetailModel => _goodsDetailModel;

  // 获取后台信息
  void getGoodsInfo(String id) {
    var formData = {'goodsId':id};
    request('goodsDetail', formData: formData).then((val){
      final data = val['data'];
      print('detail===== $data');
      _goodsDetailModel = GoodsDetailModel.fromJson(data);
      notifyListeners();
    });
  }

}