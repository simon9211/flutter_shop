import 'package:flutter/material.dart';

import 'pages/index_page.dart';
import 'package:provide/provide.dart';
import 'provide/counter.dart';
import 'provide/child_category.dart';

void main() {
  // var counter = Counter();
  var providers = Providers()
    // ..provide(Provider<Counter>.value(counter));
    ..provide(Provider.function((context) => Counter()))
    ..provide(Provider.function((context) => ChildCategory()))
    ..provide(Provider.function((context) => SubCategory()));


  runApp(ProviderNode(
    child: MyApp(),
    providers: providers,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.pink),
        home: IndexPage(),
      ),
    );
  }
}
