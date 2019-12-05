import 'package:flutter/material.dart';
import 'package:flutter_shop/provide/details_info.dart';
import 'package:provide/provide.dart';
import 'detailWidgets/details_bottom.dart';
import 'detailWidgets/details_tabbar.dart';
import 'detailWidgets/details_top_area.dart';
import 'detailWidgets/detail_explain.dart';
import 'detailWidgets/details_web.dart';

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
            return Stack(
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    DetailsTopArea(),
                    DetailsExplain(),
                    DetailTabBar(),
                    DetailsWeb(),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: DetailsBottomBtns(),
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

  Future _getDetailInfo(BuildContext context) async {
    Provide.value<DetailsInfoProvide>(context).getGoodsInfo(goodsId);
    print('done');
    return 'done';
  }
}
