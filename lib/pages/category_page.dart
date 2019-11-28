import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/pages/home_page.dart';
import '../service/service_method.dart';
import '../model/category.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int _selectIndex;
  List<CategoryModel> _categoryModelList;

  @override
  void initState() {
    _selectIndex = 0;
    _categoryModelList = [];
    _getCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品分类'),
      ),
      body: Row(
        children: <Widget>[
          LeftCategoryNavi(
            _categoryModelList,
            onSelected: (index) {
              setState(() {
                _selectIndex = index;
              });
              print('category index $index');
            },
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                TopSubCategoryWidget(
                  _categoryModelList[_selectIndex],
                  onSelected: (index) {
                    print('sub index $index');
                  },
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    padding: EdgeInsets.all(5.0),
                    children: List.generate(10,(i) => _gridViewItemUI(context, {
                        "image":
                            "https://www.baidu.com/img/bd_logo1.png?where=super",
                        "mallCategoryName": "百度"
                      }),
                    ),
                ))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _gridViewItemUI(BuildContext context, item) {
    return InkWell(
      onTap: () {
        print('click navi item');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.network(
            item['image'],
            width: ScreenUtil().setWidth(150),
          ),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }

  void _getCategory() async {
    request('categoryPageContent').then((val) {
      var data = val['data'];
      CategoryListModel category = CategoryListModel.fromJson(data['category']);
      print('data count ====${category.data.length}');
      setState(() {
        _categoryModelList = category.data;
      });
      // category.data.forEach((item) {
      //   print('--category name=== ${item.mallCategoryName}');
      //   item.bxMallSubDto.forEach((subItem) => print('--sub category name=== ${subItem.mallSubName}'));
      // });
    });
  }
}

class LeftCategoryNavi extends StatefulWidget {
  final List<CategoryModel> categoryModelList;
  final ValueChanged<int> onSelected;
  const LeftCategoryNavi(this.categoryModelList, {this.onSelected});
  @override
  _LeftCategoryNaviState createState() => _LeftCategoryNaviState();
}

class _LeftCategoryNaviState extends State<LeftCategoryNavi> {
  int _selectIndex;

  @override
  void initState() {
    _selectIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(right: BorderSide(width: 1, color: Colors.black12))),
      child: ListView.builder(
        itemCount: widget.categoryModelList.length,
        itemBuilder: (context, index) {
          return _leftInkWell(index);
        },
      ),
    );
  }

  Widget _leftInkWell(int index) {
    return InkWell(
      onTap: () {
        widget.onSelected(index);
        if (_selectIndex != index) {
          setState(() {
            _selectIndex = index;
          });
        }
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10, top: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: Text(
          widget.categoryModelList[index].mallCategoryName,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              color: index != _selectIndex ? Colors.black : Colors.pink),
        ),
      ),
    );
  }
}

class TopSubCategoryWidget extends StatefulWidget {
  final CategoryModel model;
  final ValueChanged<int> onSelected;

  const TopSubCategoryWidget(this.model, {this.onSelected});

  @override
  _TopSubCategoryWidgetState createState() => _TopSubCategoryWidgetState();
}

class _TopSubCategoryWidgetState extends State<TopSubCategoryWidget> {
  int _selectIndex;

  @override
  void initState() {
    _selectIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> categoryWidgetList =
        List.generate(widget.model.bxMallSubDto.length, (i) {
      return _topInkWell(i + 1);
    });

    categoryWidgetList.insert(0, _topInkWell(0));
    return Container(
        height: ScreenUtil().setWidth(64),
        alignment: Alignment.center,
        // color: Colors.blue,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: categoryWidgetList,
        ));
  }

  Widget _topInkWell(index) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.only(
          left: 5,
          right: 5,
        ),
        child: Text(
          index == 0 ? '全部' : widget.model.bxMallSubDto[index - 1].mallSubName,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              color: index != _selectIndex ? Colors.black : Colors.pink),
        ),
      ),
      onTap: () {
        if (_selectIndex != index) {
          widget.onSelected(index);
          setState(() {
            _selectIndex = index;
          });
        }
      },
    );
  }
}
