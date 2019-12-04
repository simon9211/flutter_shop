import 'package:flutter/material.dart';
import 'package:flutter_shop/service/service_method.dart';
import '../model/detail.dart';

class DetailsPage extends StatefulWidget {

  final String goodsId;

  const DetailsPage({Key key, this.goodsId}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  GoodsDetailModel _detailModel;

  @override
  void initState() {
    request('goodsDetail', formData: {'goodId':'${widget.goodsId}'}).then((val){
      print('detail===== $val');
      final data = val['data'];
      setState(() {
        _detailModel = GoodsDetailModel.fromJson(data);
        print('model===== $val');
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var name = _detailModel != null?_detailModel.goodInfo.goodsName:'111';
    return Scaffold(
      appBar: AppBar(
        title: Text('商品详情'),
      ),
      body: Container(
        child: Center(
          child: Text('商品id ${widget.goodsId} name $name'),
        ),
      ),
    );
  }
}

