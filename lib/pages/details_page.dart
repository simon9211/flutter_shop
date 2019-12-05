import 'package:flutter/material.dart';
import 'package:flutter_shop/provide/details_info.dart';
import '../model/detail.dart';
import 'package:provide/provide.dart';
import 'detailWidgets/details_tabbar.dart';
import 'detailWidgets/details_top_area.dart';
import 'detailWidgets/detail_explain.dart';


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
                  DetailsTopArea(),
                  DetailsExplain(),
                  DetailTabBar()
                ],
              )
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
