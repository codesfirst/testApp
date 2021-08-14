import 'package:flutter/material.dart';
import 'package:flutter_testapp/src/pages/home_page.dart';
import 'package:flutter_testapp/src/pages/info_page.dart';
import 'package:flutter_testapp/src/pages/splash_screen_page.dart';


Map <String, WidgetBuilder>getApplicationRoutes() => {
  '/': (_) => SplashScreenPage(),
  HomePage.routeName: (_) => HomePage(),
  InfoPage.routeName: (_) => InfoPage(),
};

getRouteSettings(RouteSettings settings) {
  final List<String>? pathElements = settings.name?.split('/');
  if (pathElements == null) return null;
  if (pathElements[0] == '') return null;
}