import 'package:flutter/material.dart';
import 'router_handler.dart';
import 'package:fluro/fluro.dart';

class Application {
  static Router router = Router();
  
}


class Routes {
  static String root = '/';
  static String detailsPage = '/detail';
  static String mapViewPage = '/mapView';


  static void configDetailRoutes(Router router) {
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>>params) {
        print('ERROR ===> ROUTE WAS NOT FOUND!!!! $params');
        return Text('ERROR ===> ROUTE WAS NOT FOUND!!!! $params');
      },
    );

    router.define(detailsPage, handler: detailsHandler);
  }

  static void configMapViewRoutes(Router router) {
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>>params) {
        print('ERROR ===> ROUTE WAS NOT FOUND!!!! $params');
        return Text('ERROR ===> ROUTE WAS NOT FOUND!!!! $params');
      },
    );

    router.define(mapViewPage, handler: mapViewHandler);
  }
}