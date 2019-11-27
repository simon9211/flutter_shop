import 'package:dio/dio.dart';
import 'dart:async';
import '../config/service_url.dart';

Future request(url, {formData}) async {
  try {
    print('url $url ----');
    Response response;
    Dio dio = Dio();
    response = await dio.post(
      servicePath[url], 
      data: formData != null?formData:null);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('接口异常');
    }
  } catch (e) {
    return print('url $url error:======$e');
  }
}
