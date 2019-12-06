import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provide/cart.dart';
import 'package:provide/provide.dart';
import '../../model/cartInfo.dart';

class CartItem extends StatelessWidget {
  final CartInfoModel item;

  const CartItem({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(item);
    return Container(
      margin: EdgeInsets.fromLTRB(5, 2, 5, 2),
      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: Row(
        children: <Widget>[
          _cartCheckBt(item),
          _cartImage(item),
          _cartGoodsName(context, item),
          _cartPrice(context, item)
        ],
      ),
    );
  }

  Widget _cartCheckBt(item) {
    return Container(
      margin: EdgeInsets.only(top: 0),
      child: Checkbox(
        value: item.isCheck,
        activeColor: Colors.pink,
        onChanged: (bool val) {},
      ),
    );
  }

  Widget _cartImage(item) {
    return Container(
      width: ScreenUtil().setWidth(150),
      padding: EdgeInsets.all(3),
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
      child: Image.network(item.images),
    );
  }

  Widget _cartGoodsName(context, item) {
    return Container(
      width: ScreenUtil().setWidth(300),
      padding: EdgeInsets.all(10),
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(item.goodsName),
          Container(
            width: ScreenUtil().setWidth(165),
            margin: EdgeInsets.only(top: 5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black12)),
            child: Row(
              children: <Widget>[
                _reduceBtn(context),
                _countArea(context),
                _addBtn(context)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _cartPrice(context, item) {
    return Container(
      width: ScreenUtil().setWidth(150),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Text('￥${item.price}'),
          Container(
            child: InkWell(
              onTap: () {
                Provide.value<CartProvide>(context).deleteGoods(item.goodsId);
              },
              child: Icon(
                Icons.delete_forever,
                color: Colors.black26,
                size: 30,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _reduceBtn(context) {
    return InkWell(
      onTap: item.count == 1
          ? null
          : () {
              Provide.value<CartProvide>(context).reduce(item.goodsId);
            },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(right: BorderSide(width: 1, color: Colors.black12))),
        child: Text('-'),
      ),
    );
  }

  Widget _addBtn(context) {
    return InkWell(
      onTap: () {
        Provide.value<CartProvide>(context).save(
            item.goodsId, item.goodsName, item.count, item.price, item.images);
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(left: BorderSide(width: 1, color: Colors.black12))),
        child: Text('+'),
      ),
    );
  }

  Widget _countArea(context) {
    return Provide<CartProvide>(builder: (context, child, val) {
      List cartList = Provide.value<CartProvide>(context).cartList;
      cartList.forEach((i) {
        if (i.goodsId == item.goodsId) {
          item.count = i.count;
        }
      });
      return Container(
        width: ScreenUtil().setWidth(70),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        color: Colors.white,
        child: Text('${item.count}'),
      );
    });
  }
}

class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      color: Colors.white,
      width: ScreenUtil().setWidth(750),
      child: Row(
        children: <Widget>[selectAllBtn(), allPriceArea(), goButton()],
      ),
    );
  }

  Widget selectAllBtn() {
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            value: true,
            activeColor: Colors.pink,
            onChanged: (bool val) {},
          ),
          Text('全选')
        ],
      ),
    );
  }

  Widget allPriceArea() {
    return Container(
      width: ScreenUtil().setWidth(430),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(280),
                child: Text('合计:',
                    style: TextStyle(fontSize: ScreenUtil().setSp(36))),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: ScreenUtil().setWidth(150),
                child: Text('￥1922',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(36),
                      color: Colors.red,
                    )),
              )
            ],
          ),
          Container(
            width: ScreenUtil().setWidth(430),
            alignment: Alignment.centerRight,
            child: Text(
              '满10元免配送费，预购免配送费',
              style: TextStyle(
                  color: Colors.black38, fontSize: ScreenUtil().setSp(22)),
            ),
          )
        ],
      ),
    );
  }

  Widget goButton() {
    return Container(
      width: ScreenUtil().setWidth(160),
      padding: EdgeInsets.only(left: 10),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(3.0)),
          child: Text(
            '结算(6)',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
