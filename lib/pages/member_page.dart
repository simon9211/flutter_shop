import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/routers/routers.dart';

class MemberPage extends StatelessWidget {
  List _items = [['待付款', Icons.party_mode],['待发货', Icons.query_builder], ['待收货', Icons.receipt], ['待评价', Icons.note]];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('会员中心'),
      ),
      body: ListView(
        children: <Widget>[
          _topHeader(),
          _orderTitle(),
          _orderCategory(),
          _actionList(context)
        ],
      )
    );
  }

  Widget _topHeader() {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(20),
      color: Colors.pinkAccent,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30),
            child: ClipOval(
              child: Image.network('http://blogimages.jspang.com/blogtouxiang1.jpg'),
            )
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              'Simon',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(36),
                color: Colors.white
              ),
              ),
          )
        ],
      ),
    );
  }

  Widget _orderTitle() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.black12)
        )
      ),
      child: ListTile(
        leading: Icon(Icons.list),
        title: Text('我的订单'),
        trailing: Icon(Icons.arrow_right),
      ),
    );
  }

  Widget _orderCategory() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _items.map((item){
          return Container(
            child: InkWell(
              onTap: (){},
              child: Column(
                children: <Widget>[
                  Icon(
                    item[1],
                    color: Colors.grey,
                    size: 30,
                    ),
                  SizedBox(height: 5,),
                  Text(item[0])
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _actionList(context) {
    List titles = [ '领取优惠券', '已领取优惠券', '地址管理', '客服电话', '关于我们'];
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: titles.map((title){
          return _customListTile(context, title);
        }).toList(),
      ),
    );
  }

  Widget _customListTile(context,String title) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.black12)
        )
      ),
      child: ListTile(
        leading: Icon(Icons.blur_circular),
        title: Text(title),
        trailing: Icon(Icons.arrow_right),
        onTap: (){
          Application.router.navigateTo(context,"/mapView?name=mapView");
        },
      ),
    );
  }
}