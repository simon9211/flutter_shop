import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../pages/details_page.dart';
import '../pages/map.dart';

Handler detailsHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String goodsId = params['id'].first;
    print('index details goods id is $goodsId');
    return DetailsPage(goodsId: goodsId,);
  },
);

Handler mapViewHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String title = params['name'].first;
    print('index mapView title is $title');
    return CustomMapView(title: title,);
  },
);