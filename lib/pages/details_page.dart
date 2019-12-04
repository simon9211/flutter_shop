import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;

  const DetailsPage({Key key, this.goodsId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品详情'),
      ),
      body: Container(
        child: Center(
          child: Text('商品id $goodsId'),
        ),
      ),
    );
  }
}
