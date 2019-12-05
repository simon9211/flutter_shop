import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provide/details_info.dart';
import 'package:provide/provide.dart';
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
                  child: _bottomBtns(),
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

  Widget _bottomBtns() {
    return Container(
      width: ScreenUtil().setWidth(750),
      color: Colors.white,
       height: ScreenUtil().setHeight(80),
      child: Row(
      children: <Widget>[
        InkWell(
          onTap: () {},
          child: Container(
            width: ScreenUtil().setWidth(110),
            alignment: Alignment.center,
            child: Icon(
              Icons.shopping_cart,
              size: 35,
              color: Colors.red,
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(320),
              height: ScreenUtil().setHeight(80),
              color: Colors.green,
              child: Text(
                '加入购物车',
                style: TextStyle(
                    color: Colors.white, fontSize: ScreenUtil().setSp(28)),
              ),
            ),
          ),
          flex: 1,
        ),
        Expanded(
          child: InkWell(
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(320),
              height: ScreenUtil().setHeight(80),
              color: Colors.red,
              child: Text(
                '立即购买',
                style: TextStyle(
                    color: Colors.white, fontSize: ScreenUtil().setSp(28)),
              ),
            ),
          ),
          flex: 1,
        )
      ],
    ),
    );
  }

  Future _getDetailInfo(BuildContext context) async {
    Provide.value<DetailsInfoProvide>(context).getGoodsInfo(goodsId);
    print('done');
    return 'done';
  }
}
