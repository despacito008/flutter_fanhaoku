import 'package:flutter/material.dart';
import 'provide/fanhao.dart';
import "fanhaoku_page.dart";
import 'package:provide/provide.dart';
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "demo",
      home: new FanHaoKu(),
    );
  }
}
void runMyApp() {
  var counter = Fanhao();
  var providers = Providers();
  providers..provide(Provider<Fanhao>.value(counter));
  runApp(ProviderNode(
    child: MyApp(),
    providers: providers,
  ));
}

void main() {
  runMyApp();
}
