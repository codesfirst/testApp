import 'package:flutter/material.dart';
import 'package:flutter_testapp/src/pages/home_page.dart';
import 'package:flutter_testapp/src/utils/responsive.dart';

class SplashScreenPage extends StatefulWidget {
  SplashScreenPage({Key? key}) : super(key: key);

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        toolbarHeight: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.cyanAccent
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/logo.png", width: Responsive.of(context).wp(40),),
              SizedBox(height: 10,),
              CircularProgressIndicator(),
              SizedBox(height: 10,),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text( "Inicializando....", style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _initData() async {
    //Aqui se podria poner carga de datos iniciales
    await Future.delayed(Duration(seconds: 3), (){
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    });
  }
}