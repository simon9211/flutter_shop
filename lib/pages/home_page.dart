import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_shop/routers/routers.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  String homePageContent = '正在获取数据';
  int page = 1;
  List<Map> hotGoodsList = [];
  @override
  void initState() {
    super.initState();
    print('1111111');
    //_getHotGoods();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('百姓生活+'),
        ),
        body: FutureBuilder(
          future: request('homePageContent'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data['data'];
              List<Map> swiper = (data['slides'] as List).cast();
              List<Map> navigatorList = (data['category'] as List).cast();
              String adPicture = data['advertesPicture']['picture_adress'];
              String leaderImage = data['shopInfo']['leaderImage'];
              String leaderPhone = data['shopInfo']['leaderPhone'];

              List<Map> recomandList = (data['recomand'] as List).cast();

              String floorTitle = data['floorPic']['picture_address'];
              List<Map> floor = (data['floor'] as List).cast();

              return EasyRefresh(
                footer: ClassicalFooter(
                  bgColor: Colors.green,
                  textColor: Colors.pink,
                  infoColor: Colors.pink,
                  noMoreText: 'no more data',
                  infoText: 'info text',
                  loadingText: 'loading …',
                  loadText: 'loading more',
                  showInfo: true
                ),
                child: ListView(
                  children: <Widget>[
                    SwiperDiy(
                      swiperDataList: swiper,
                    ),
                    TopNavigator(
                      navigatorList: navigatorList,
                    ),
                    AdBanner(
                      adPicture: adPicture,
                    ),
                    LeaderPhone(
                      leaderImage: leaderImage,
                      leaderPhone: leaderPhone,
                    ),
                    Recomand(
                      recomandList: recomandList,
                    ),
                    FloorTitle(
                      pictureAdress: floorTitle,
                    ),
                    FloorContent(
                      floorGoodsList: floor,
                    ),
                    FloorTitle(
                      pictureAdress: floorTitle,
                    ),
                    FloorContent(
                      floorGoodsList: floor,
                    ),
                    // HotGoods(),
                    _hotGoods()
                  ],
                ),
                onLoad: () async {
                  print('onLoad');
                  var formPage = {'page': page};
                  request('homePageBelowContent', formData: formPage)
                      .then((val) {
                    var data = val['data'];
                    List<Map> newHotGoodsList =
                        (data['hotGoods'] as List).cast();
                    setState(() {
                      hotGoodsList.addAll(newHotGoodsList);
                      page++;
                    });
                  });
                },
                onRefresh: () async {
                  print('onRefresh');
                },
              );
            } else {
              return Center(
                child: Text(homePageContent),
              );
            }
          },
        ));
  }

  @override
  bool get wantKeepAlive => true;

  void _getHotGoods() {
    var formPage = {'page': page};
    request('homePageBelowContent', formData: formPage).then((val) {
      var data = val['data'];
      List<Map> newHotGoodsList = (data['hotGoods'] as List).cast();
      setState(() {
        hotGoodsList.addAll(newHotGoodsList);
        page++;
      });
    });
  }

  Widget hotTitle = Container(
    margin: EdgeInsets.only(top: 10),
    alignment: Alignment.center,
    color: Colors.transparent,
    child: Text('火爆专区'),
  );

  Widget _wrapList() {
    if (hotGoodsList.length != 0) {
      List<Widget> listWidget = hotGoodsList.map((item) {
        return InkWell(
          onTap: () {
            Application.router.navigateTo(context,"/detail?id=1111");
          },
          child: Container(
            width: ScreenUtil().setWidth(372),
            color: Colors.white,
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(bottom: 3.0),
            child: Column(
              children: <Widget>[
                Image.network(
                  item['image'],
                  width: ScreenUtil().setWidth(370),
                ),
                Text(
                  item['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.pink, fontSize: ScreenUtil().setSp(26)),
                ),
                Row(
                  children: <Widget>[
                    Text('¥${item['mallPrice']}'),
                    Text('¥${item['price']}',
                        style: TextStyle(
                            color: Colors.black26,
                            decoration: TextDecoration.lineThrough))
                  ],
                )
              ],
            ),
          ),
        );
      }).toList();

      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    } else {
      return Text('data');
    }
  }

  Widget _hotGoods() {
    return Container(
      child: Column(
        children: <Widget>[hotTitle, _wrapList()],
      ),
    );
  }
}

// 首页轮播
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;

  const SwiperDiy({Key key, this.swiperDataList}) : super(key: key);

  // const SwiperDiy({this.swiperDataList});
  @override
  Widget build(BuildContext context) {
    // print('设备像素密度 ${ScreenUtil.pixelRatio}');
    // print('设备高度 ${ScreenUtil.screenHeight}');
    // print('设备宽度 ${ScreenUtil.screenWidth}');
    return Container(
      color: Colors.green,
      height: ScreenUtil().setHeight(300),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            '${swiperDataList[index]['image']}',
            fit: BoxFit.fill,
          );
        },
        itemCount: swiperDataList.length,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

// 菜单
class TopNavigator extends StatelessWidget {
  final List navigatorList;

  const TopNavigator({Key key, this.navigatorList}) : super(key: key);

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
            width: ScreenUtil().setWidth(95),
          ),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(280),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 5,
        padding: EdgeInsets.all(5.0),
        children: navigatorList.map((item) {
          return _gridViewItemUI(context, item);
        }).toList(),
      ),
    );
  }
}

// 广告
class AdBanner extends StatelessWidget {
  final String adPicture;

  const AdBanner({Key key, this.adPicture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Image.network(
        adPicture,
        height: ScreenUtil().setHeight(60),
        width: ScreenUtil().setWidth(750),
        fit: BoxFit.fill,
      ),
    );
  }
}

// 店长电话
class LeaderPhone extends StatelessWidget {
  final String leaderImage, leaderPhone;

  const LeaderPhone({Key key, this.leaderImage, this.leaderPhone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _lanchURL,
        child: Image.network(leaderImage),
      ),
    );
  }

  void _lanchURL() async {
    // String url = 'tel:' + leaderPhone;
    String url = 'http://flutter.dev';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'url can not be launched';
    }
  }
}

// 商品推荐
class Recomand extends StatelessWidget {
  final List recomandList;

  const Recomand({Key key, this.recomandList}) : super(key: key);

  // 标题
  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10, 2.0, 0, 5),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(width: 0.5, color: Colors.black12))),
      child: Text(
        '商品推荐',
        style: TextStyle(color: Colors.pink),
      ),
    );
  }

  // 商品
  Widget _item(index) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: ScreenUtil().setHeight(330),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(left: BorderSide(width: 0.5, color: Colors.black12))),
        child: Column(
          children: <Widget>[
            Image.network(
              recomandList[index]['image'],
              height: ScreenUtil().setHeight(230),
              fit: BoxFit.fill,
            ),
            Text('¥${recomandList[index]['price']}'),
            Text(
              '¥${recomandList[index]['mallPrice']}',
              style: TextStyle(
                  decoration: TextDecoration.lineThrough, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }

  // 列表
  Widget _recomandList() {
    return Container(
      height: ScreenUtil().setHeight(320),
      margin: EdgeInsets.only(top: 10.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recomandList.length,
        itemBuilder: (context, index) {
          return _item(index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(380),
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[_titleWidget(), _recomandList()],
      ),
    );
  }
}

// 楼层title
class FloorTitle extends StatelessWidget {
  final String pictureAdress;

  const FloorTitle({Key key, this.pictureAdress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Image.network(pictureAdress),
    );
  }
}

// 楼层商品列表
class FloorContent extends StatelessWidget {
  final List floorGoodsList;

  const FloorContent({Key key, this.floorGoodsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[_firstRow(), _otherGoods()],
      ),
    );
  }

  Widget _firstRow() {
    return Row(
      children: <Widget>[
        _goodsItem(floorGoodsList[0]),
        Column(
          children: <Widget>[
            _goodsItem(floorGoodsList[1]),
            _goodsItem(floorGoodsList[2]),
          ],
        )
      ],
    );
  }

  Widget _otherGoods() {
    return Row(
      children: <Widget>[
        _goodsItem(floorGoodsList[3]),
        _goodsItem(floorGoodsList[4]),
      ],
    );
  }

  Widget _goodsItem(Map goods) {
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: () {
          print('item click');
        },
        child: Image.network(goods['image']),
      ),
    );
  }
}

// 火爆专区
class HotGoods extends StatefulWidget {
  @override
  _HotGoodsState createState() => _HotGoodsState();
}

class _HotGoodsState extends State<HotGoods> {
  @override
  void initState() {
    super.initState();
    request('homePageBelowContent').then((val) {
      print('hot goods $val');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('data'),
    );
  }
}

/// demo
class HomePage1 extends StatefulWidget {
  HomePage1({Key key}) : super(key: key);

  @override
  _HomePage1State createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  final httpHeader = {
    'Accept': 'application/json, text/plain, */*',
    'Accept-Encoding': 'gzip, deflate, br',
    'Accept-Language': 'zh-CN,zh;q=0.9,en;q=0.8',
    'Connection': 'keep-alive',
    'Cookie':
        '_ga=GA1.2.2098043171.1567393863; _gid=GA1.2.1768179064.1574063453; Hm_lvt_022f847c4e3acd44d4a2481d9187f1e6=1574063453; GRID=80fd9be-69a26dd-b33e2aa-361eaef; MEIQIA_TRACK_ID=1TmRpo31d2im3WMRoNqZ5xyls9N; MEIQIA_VISIT_ID=1TmRpm4c2FImTaXqAo50mx6acan; SERVERID=1fa1f330efedec1559b3abbcb6e30f50|1574063536|1574063450; _gat=1; Hm_lpvt_022f847c4e3acd44d4a2481d9187f1e6=1574063537',
    'Host': 'time.geekbang.org',
    'Origin': 'https://time.geekbang.org',
    'Referer': 'https://time.geekbang.org/',
    'Sec-Fetch-Mode': 'cors',
    'Sec-Fetch-Site': 'same-origin',
    'User-Agent':
        'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.87 Safari/537.36',
  };

  TextEditingController typeController = TextEditingController();
  String showText = 'welcome to alibab';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('天上人间'),
        ),
        body: Center(
          child: RaisedButton(
            onPressed: () {
              request('21', formData: '21').then((val) {
                print(val);
              });
              // _choiceAction();
              // getHttp1().then((val) {
              //   setState(() {
              //     showText = val['data'].toString();
              //     print(showText);
              //   });
              // });
            },
            child: Text('done'),
          ),
        ));
  }

  Future getHttp(String TypeText) async {
    try {
      Response response;
      var data = {'name': TypeText};
      print('start request');
      response = await Dio().get(
          'https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian',
          queryParameters: data);
      return print(response);
    } catch (e) {
      print('error request');
      return print(e);
    }
  }

  void _choiceAction() {
    print('start choice girls');
    if (typeController.text.toString() == '') {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('not to be null'),
              ));
    } else {
      getHttp(typeController.text.toString()).then((val) {
        setState(() {});
      });
    }
  }

  Future getHttp1() async {
    try {
      Response response;
      Dio dio = Dio();
      dio.options.headers = httpHeader;
      response =
          await dio.get('https://time.geekbang.org/serv/v1/column/topList');
      return response.data;
    } catch (error) {
      return print(error);
    }
  }
}
