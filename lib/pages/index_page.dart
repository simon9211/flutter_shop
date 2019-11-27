import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home_page.dart';
import 'cart_page.dart';
import 'category_page.dart';
import 'member_page.dart';

BottomNavigationBarItem _createItem(String title, IconData icon) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
      ), 
      title: Text(
        title,
      )
    );
  }

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {

  final _bottomNavigationColorSelected = Colors.pink;
  final _bottomNavigationColorNormal = Colors.grey;
  int _currentIndex = 0;
  var _currentPage;
  List<Widget> _items = [];

  @override
  void initState() {
    _items
      ..add(HomePage())
      ..add(CategoryPage())
      ..add(CartPage())
      ..add(MemberPage());
    super.initState();
  }

  final List<BottomNavigationBarItem> bottomTabs = [
    _createItem('首页', CupertinoIcons.home),
    _createItem('分类', CupertinoIcons.search),
    _createItem('购物车', CupertinoIcons.shopping_cart),
    _createItem('会员中心', CupertinoIcons.profile_circled),
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334) .. init(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      // appBar: AppBar(
      //   title: bottomTabs[_currentIndex].title,
      // ), 
      body: IndexedStack(
        index: _currentIndex,
        children: _items,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        items: bottomTabs,
        onTap: (idx) {
          if (idx != _currentIndex) {
            setState(() {
              _currentIndex = idx;
            });
          }
        },
      ),
    );
  }
}