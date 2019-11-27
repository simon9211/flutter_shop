import 'package:flutter/material.dart';
import '../service/service_method.dart';
import '../model/category.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  @override
  Widget build(BuildContext context) {
    _getCategory();
    return Container(
      child: Center(
        child: Text('category'),
      ),
    );
  }

  void _getCategory() async {
    request('categoryPageContent').then((val) {
      var data = val['data'];
      CategoryListModel list = CategoryListModel.fromJson(data['category']);
      print('data count ====${list.data.length}');
      list.data.forEach((item) {
        print('--category name=== ${item.mallCategoryName}');
        item.bxMallSubDto.forEach((subItem) => print('--sub category name=== ${subItem.mallSubName}'));

      });
    });
  }
}
