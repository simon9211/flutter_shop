import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../service/service_method.dart';
import '../model/category.dart';
import '../provide/child_category.dart';
import '../provide/category_goods_list.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int _selectIndex;
  List<CategoryModel> _categoryModelList;
  CategoryDetailListModel _detailList;

  @override
  void initState() {
    _categoryModelList = [];
    _getCategory();
    super.initState();
    _getCategoryDetail();
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
            // onSelected: (index) {
            //   setState(() {
            //     _selectIndex = index;
            //   });
            //   print('category index $index');
            // },
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Provide<ChildCategory>(
                  builder: (context, child, childCategory) {
                    return TopSubCategoryWidget(
                      childCategory.childCategoryList,
                      // onSelected: (index) {
                      //   print('sub index $index');
                      // },
                    );
                  },
                ),
                Expanded(child: Provide<SubCategory>(
                  builder: (context, child, it) {
                    return GridView.count(
                      crossAxisCount: 2,
                      padding: EdgeInsets.all(5.0),
                      children: _detailList != null
                          ? List.generate(
                              _detailList.data.length,
                              (i) => _gridViewItemUI(context, item: _detailList.data[i], model:it.subCategoryModel),
                            )
                          : [Text('null')],
                    );
                  },
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _gridViewItemUI(BuildContext context, {CategoryDetailItemModel item, CategoryItemModel model}) {
    return InkWell(
      onTap: () {
        print('click navi item');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.network(
            item.image,
            width: ScreenUtil().setWidth(150),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 0),
            alignment: Alignment.topLeft,
            height: 40,
            child: Text(
              item.goodsName, 
              maxLines: 2, 
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '¥${item.presentPrice}', 
                style: TextStyle(
                  color: Colors.red
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                '¥${item.oriPrice}',
                style: TextStyle(
                    color: Colors.black26,
                    decoration: TextDecoration.lineThrough)
              ),
              Text(
                ' (${model.mallSubName})'
              )
            ],
          )
        ],
      ),
    );
  }

  void _getCategory() async {
    request('categoryPageContent').then((val) {
      final data = val['data'];
      CategoryListModel category = CategoryListModel.fromJson(data['category']);
      print('data count ====${category.data.length}');
      setState(() {
        _categoryModelList = category.data;
      });

      final _currentList = Provide.value<ChildCategory>(context);
      _currentList.getChildCategory(_categoryModelList[0].bxMallSubDto);

      final _goodsList = Provide.value<SubCategory>(context);
      _goodsList.getCategoryItemModel(CategoryItemModel(
          comments: '',
          mallCategoryId: '0',
          mallSubName: '全部',
          mallSubId: '0'));

      // category.data.forEach((item) {
      //   print('--category name=== ${item.mallCategoryName}');
      //   item.bxMallSubDto.forEach((subItem) => print('--sub category name=== ${subItem.mallSubName}'));
      // });
    });
  }

  void _getCategoryDetail() async {
    request('categoryPageDetail').then((val) {
      // print('detail $val');
      final data = val['data'];
      setState(() {
        _detailList = CategoryDetailListModel.fromJson(data['categoryDetail']);
      });
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
    final _currentList = Provide.value<ChildCategory>(context);
    return InkWell(
      onTap: () {
        _currentList
            .getChildCategory(widget.categoryModelList[index].bxMallSubDto);
        // widget.onSelected(index);
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
  final List<CategoryItemModel> subCategoryList;
  final ValueChanged<int> onSelected;

  const TopSubCategoryWidget(this.subCategoryList, {this.onSelected});

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
        List.generate(widget.subCategoryList.length, (i) {
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
          index == 0 ? '全部' : widget.subCategoryList[index - 1].mallSubName,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              color: index != _selectIndex ? Colors.black : Colors.pink),
        ),
      ),
      onTap: () {
        if (_selectIndex != index) {
          // widget.onSelected(index);
          final _currentList = Provide.value<SubCategory>(context);
          if (index != 0) {
            _currentList
                .getCategoryItemModel(widget.subCategoryList[index - 1]);
          } else {
            _currentList.getCategoryItemModel(CategoryItemModel(
                comments: '',
                mallCategoryId: '0',
                mallSubName: '全部',
                mallSubId: '0'));
          }
          setState(() {
            _selectIndex = index;
          });
        }
      },
    );
  }
}
