import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';

// 获取首页
Future getHomePageContent() async {
  try {
    print('getHomePageContent----');
    Response response;
    Dio dio = Dio();
    response = await dio.post(
      servicePath['homePageContent'], 
      data: null);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('接口异常');
    }
  } catch (e) {
    return print('error:======$e');
  }
}
