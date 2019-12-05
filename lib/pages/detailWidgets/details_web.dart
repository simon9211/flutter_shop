import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/details_info.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsDetail = Provide.value<DetailsInfoProvide>(context).goodsDetailModel;
    return Provide<DetailsInfoProvide>(
      builder: (context, child, val) {
        var idx = Provide.value<DetailsInfoProvide>(context).idx;
        if (idx == 0) {
          return Container(
            child: Html(
              data: goodsDetail.goodInfo.goodsDetail,
            ),
          );
        } else {
          return Container(
            width: ScreenUtil().setWidth(750),
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(top: 20),
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Text('暂时还没有评论喔！', style: TextStyle(color: Colors.black26)),
                Image.network(
                  goodsDetail.advertesPicture.pictureAddress,
                  width: ScreenUtil().setWidth(770),
                )
              ],
            ),
          );
        }
      },
    );
  }
}
