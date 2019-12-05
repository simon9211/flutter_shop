import 'package:flutter/material.dart';
import '../model/detail.dart';
import '../service/service_method.dart';

class DetailsInfoProvide with ChangeNotifier {
  GoodsDetailModel goodsDetailModel;

  //GoodsDetailModel get goodsDetailModel => _goodsDetailModel;

  // 获取后台信息
  void getGoodsInfo(String id) {
    var formData = {'goodsId':id};
    request('goodsDetail', formData: formData).then((val){
      final data = val['data'];
      print('detail===== $data');
      goodsDetailModel = GoodsDetailModel.fromJson(data);
      notifyListeners();
    });
  }

  int idx = 0;
  void tabSelectIndex(int index) {
    idx = index;
    notifyListeners();
  }

}

