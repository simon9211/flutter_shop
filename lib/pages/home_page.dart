import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String homePageContent = '正在获取数据';

  @override
  void initState() {
    getHomePageContent().then((val) {
      homePageContent = val.toString();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('百姓生活+'),
      ),
      body: FutureBuilder(
        future: getHomePageContent(),
        builder: (context, snapshot){
          if (snapshot.hasData) {
            var data = snapshot.data;
            List<Map> swiper = (data['data']['slides'] as List).cast();
            return Column(
              children: <Widget>[
                SwiperDiy(swiperDataList: swiper,)
              ],
            );
          } else {
            return Center(child: Text('no data'),);
          }
        },
      )
    );
  }
}




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
              getHomePageContent().then((val) {
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


// 首页轮播
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;

  const SwiperDiy({Key key, this.swiperDataList}) : super(key: key);

  // const SwiperDiy({this.swiperDataList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 333,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network('${swiperDataList[index]['image']}', fit: BoxFit.fill,);
        },
      itemCount: swiperDataList.length,
      pagination: SwiperPagination(),
      autoplay: true,
      ),
    );
  }
}