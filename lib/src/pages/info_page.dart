import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_testapp/src/bloc/equipos_bloc.dart';
import 'package:flutter_testapp/src/models/equipo_model.dart';
import 'package:flutter_testapp/src/utils/colors.dart';
import 'package:flutter_testapp/src/utils/responsive.dart';
import 'package:flutter_testapp/src/widgets/empty_data.dart';
import 'package:flutter_testapp/src/widgets/text_widget.dart';

class InfoPage extends StatefulWidget {
  static const String routeName = "info";
  InfoPage({Key? key}) : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final eqipoBloc = EquiposBloc();
  int totalEquipo = 0;
  List<EquipoModel> listEquipo = [];
  List<String> partidos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
          stream: eqipoBloc.equipoContador,
          builder: (_, AsyncSnapshot<int> snapshot){
            totalEquipo = snapshot.data ?? 0;
            return Text("Equipos ($totalEquipo)");
          },
        ),
      ),
      body: SafeArea(
        child: Container(
          child: StreamBuilder(
            stream: eqipoBloc.getEquipos,
            builder: (BuildContext context, AsyncSnapshot<List<EquipoModel>> snapshot) {  
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 20.0,),
                          Text("Cargando Equipos....")
                        ],
                      )
                  );
                default:
                  if (snapshot.hasError) return Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error),
                          SizedBox(height: 20.0,),
                          Text("No se pudo cargar los datos, por favor intente mas tarde.")
                        ],
                      )
                  );
                  else{
                    if(!snapshot.hasData) return EmptyData();
                    listEquipo = snapshot.data ?? [];
                    if (listEquipo.length == 0) return EmptyData();
                    partidos = _generar(listEquipo.length);
                    return _createListView();
                  }
              }
            },
          ),
        ),
      ),
    );
  }

  

  _generar(int totalTeam) {
    //List<int> rangeNum = List<int>.generate(totalEquipo, (i) => i);
    //print("Total e. $totalTeam");
    partidos = [];
    int total = (totalTeam / 2).round();

    if (total > 0){
      var rng = new Random();
      print(total);
      int num2 = 0;
      int num1 = 0;
      for (int i=0; i < total; i++){
        num1 = rng.nextInt(totalTeam);
        do{
          num2 = rng.nextInt(totalTeam);
        }while(num2==num1);
        print("num1 $num1");
        print("num2 $num2");
        partidos.add("${listEquipo[num1].nombre.toUpperCase()} VS ${listEquipo[num2].nombre.toUpperCase()}");
      }
    }
    
    return  partidos;
  }

  Widget _createListView() {
    
    return Container(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: Responsive.of(context).dp(1),),
            Center(
              child: TextWidget(
                text: "Enfrentamientos - (${partidos.length})",
                color: TestColor.fromHex(TestColor.CelesteLight),
                fontSize: Responsive.of(context).dp(2.5),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: Responsive.of(context).dp(2),),
            Container(child: Image.asset("assets/images/equipos.png", width: Responsive.of(context).wp(30),)),
            SizedBox(height: Responsive.of(context).dp(2),),
            Expanded(
              child: Container(
                child: partidos.length == 0 ? Center(child: TextWidget(text: "No se pudo generar enfrentamientos")) :
                ListView.builder(
                  itemCount: partidos.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) { 
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: Responsive.of(context).dp(2), vertical: Responsive.of(context).dp(2)),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: TestColor.fromHex(TestColor.CelesteDark),
                              borderRadius: BorderRadius.circular(Responsive.of(context).dp(2))
                            ),
                            padding: EdgeInsets.symmetric(horizontal: Responsive.of(context).dp(2), vertical: Responsive.of(context).dp(2)),
                            alignment: Alignment.center,
                            child: TextWidget(
                              text: partidos[index],
                              color: Colors.white,
                              fontSize: Responsive.of(context).dp(2.5),
                            )
                          ),
                          SizedBox(height: Responsive.of(context).dp(2),)
                        ],
                      ),
                    );
                  }, 
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}