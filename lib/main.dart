import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:flutter_testapp/src/networking/api.dart';
import 'package:flutter_testapp/src/routes/route.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => Api.create(),
          dispose: (_, Api api) => api.client.dispose(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData( 
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: getApplicationRoutes(),
      ),
    );
  }
}
