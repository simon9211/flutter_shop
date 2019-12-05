import 'package:flutter/material.dart';
import 'package:flutter_shop/model/detail.dart';
import 'package:provide/provide.dart';
import '../../provide/details_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsTopArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailsInfoProvide>(
      builder: (context, child, val) {
      var goodsInfo = Provide.value<DetailsInfoProvide>(context).goodsDetailModel.goodInfo;
      if (goodsInfo != null) {
        return Container(
          padding: EdgeInsets.all(2),
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _goodsImage(goodsInfo.image1),
            _goodsInfo(goodsInfo)
          ],
        ));
      } else {
        return Text('loading');
      }
    });
  }

// 商品图片
  Widget _goodsImage(url) {
    return Image.network(
      url,
      width: ScreenUtil().setWidth(740),
    );
  }

  Widget _goodsInfo(GoodInfo goodInfo) {
    return Container(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              goodInfo.goodsName,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(30),
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            // SizedBox(
            //   height: 10,
            // ),
            Text('编号:${goodInfo.goodsSerialNumber}',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(24),
                  color: Colors.black26,
                )),
            Row(
              children: <Widget>[
                Text(
                  '¥${goodInfo.presentPrice}',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(40),
                      color: Colors.pink,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '市场价',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(28),
                    color: Colors.grey,
                  ),
                ),
                Text(
                  '¥${goodInfo.oriPrice}',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(24),
                      color: Colors.black26,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.lineThrough),
                ),
              ],
            )
          ],
        ));
  }
}
