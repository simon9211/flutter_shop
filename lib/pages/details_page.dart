import 'package:flutter/material.dart';
import 'package:flutter_shop/provide/details_info.dart';
import '../model/detail.dart';
import 'package:provide/provide.dart';

class DetailsPage extends StatelessWidget {

  final String goodsId;

  const DetailsPage({Key key, this.goodsId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品详情'),
      ),
      body: FutureBuilder(
        future: _getDetailInfo(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: Column(
                children: <Widget>[
                  Text('商品id $goodsId')
                ],
              ),
            );
          } else {
            return Text('loading');
          }
        },
      ),
    );
  }

  Future _getDetailInfo(BuildContext context) async {
    Provide.value<DetailsInfoProvide>(context).getGoodsInfo(goodsId);
    print('done');
    return 'done';
  }
}

