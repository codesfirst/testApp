import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_testapp/src/models/equipo_model.dart';
import 'package:flutter_testapp/src/models/pagination_model.dart';
import 'package:flutter_testapp/src/pages/info_page.dart';
import 'package:flutter_testapp/src/providers/equipo_request_provider.dart';
import 'package:flutter_testapp/src/utils/colors.dart';
import 'package:flutter_testapp/src/utils/constatnts.dart';
import 'package:flutter_testapp/src/utils/dialog.dart';
import 'package:flutter_testapp/src/utils/responsive.dart';
import 'package:flutter_testapp/src/widgets/empty_data.dart';
import 'package:flutter_testapp/src/widgets/loading_data.dart';
import 'package:flutter_testapp/src/widgets/shimmer_loading.dart';
import 'package:flutter_testapp/src/widgets/text_widget.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "home";

  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String dropdownValue = 'ACT';

  PaginationModel? _paginationModel;
  List<EquipoModel> _equipoModelList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text("Equipos"),
       ),
       body: SafeArea(
        child: Container(
          child: FutureBuilder(
            future: EquipoRequestProvider.getEquipos(),
            builder: (context, AsyncSnapshot<PaginationModel?> snapshot) {
              switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Container(
                  padding: EdgeInsets.symmetric(vertical: Responsive.of(context).dp(2), horizontal: Responsive.of(context).dp(1.5)),
                  child: SimmerLoading(height: Responsive.of(context).dp(8))
                );
              default:
                if (snapshot.hasError) return EmptyData();
                else{
                  if(!snapshot.hasData) return EmptyData();
                  _paginationModel = snapshot.data;
                  _equipoModelList = snapshot.data?.equipoModel ?? [];
                  if (_equipoModelList.length == 0) return EmptyData();
                  return _createListView();
                }
              }
            }
          )
        )
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "1",
            onPressed: _modalEquipo,
            child: Icon(Icons.add),
          ),
          SizedBox(height: Responsive.of(context).dp(1),),
          FloatingActionButton(
            heroTag: "2",
            onPressed: (){
              Navigator.pushNamed(context, InfoPage.routeName);
            },
            child: Icon(Icons.code_rounded),
          )
        ],
      ),
    );
  }


  Widget _createListView() =>
    Container(
      padding: EdgeInsets.symmetric(vertical: Responsive.of(context).dp(2), horizontal: Responsive.of(context).dp(1.5)),
      child: ListView.builder(
        itemCount: _equipoModelList.length,
        itemBuilder: (_, i) { 
          final equipoModel = _equipoModelList[i];
          return _itemEquipo(equipoModel);
         },
      ),
    );
  

  Widget _itemEquipo(EquipoModel equipoModel) => Dismissible(
    direction: DismissDirection.startToEnd,
    background: Container(
      padding: EdgeInsets.symmetric(horizontal: Responsive.of(context).dp(1.5)),
      alignment: Alignment.centerLeft,
      color: Colors.red,
      child: TextWidget(
        text: "Eliminar",
        color: Colors.white,
        fontSize: Responsive.of(context).dp(2),
        textAlign: TextAlign.start,
      ),
    ),
    onDismissed: (direction){
      _delete(equipoModel.id);
    },
    key: Key("${equipoModel.id}"),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: Responsive.of(context).dp(2), horizontal: Responsive.of(context).dp(1.5)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Responsive.of(context).dp(1)),
            boxShadow: [
              BoxShadow(
                color: TestColor.fromHex(TestColor.CelesteLight),
                blurRadius: 1
              ),
            ]
          ),
          child: ListTile(
            title: TextWidget(
              text: equipoModel.nombre,
              color: Colors.white,
              fontSize: Responsive.of(context).dp(2),
              
            ),
            subtitle: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: TextWidget(
                    text: (equipoModel.estado.toLowerCase().contains("act")) ? "Estado: Activado" : "Estado: Desactivado",
                    color: Colors.black,
                    fontSize: Responsive.of(context).dp(1.5),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: TextWidget(
                    text: "Creado el: ${getDateCurrentTransaction(equipoModel.fecha_creacion)}",
                    color: Colors.black,
                    fontSize: Responsive.of(context).dp(1.5),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: TextWidget(
                    text: "Ultima modificacion: ${getDateCurrentTransaction(equipoModel.ultimo_cambio)}",
                    color: Colors.black,
                    fontSize: Responsive.of(context).dp(1.5),
                  ),
                ),
              ],
            ),
            trailing: GestureDetector(
              onTap: (){
                _modalEquipo(isAdd: false, name: equipoModel.nombre, id: equipoModel.id);
              },
              child: Icon(Icons.edit, 
              color: Colors.white,)
            ),
          ),
        ),
        SizedBox(height: Responsive.of(context).dp(1.5),)
      ],
    ),
  );

  String getDateCurrentTransaction(String createdOnUtc) {
    String dateCurrent = "No hay Fecha";
    try {
      final dateCreate = DateFormat('yyyy-MM-ddTH:m:s').parse(createdOnUtc);
      dateCurrent = DateFormat("yyyy-MM-dd H:mm:ss").format(dateCreate);
    } catch(e){
      print(e);
    }
    return dateCurrent;
  }

  _modalEquipo({String? name, bool isAdd = true, int id = 0}) async {
    final textController = TextEditingController();
    if (name != null) textController.text = name;
    if (Platform.isAndroid)
      return showDialog(
        context: context, 
        builder: (BuildContext context) => StatefulBuilder(builder: (context, StateSetter setState) =>
          AlertDialog(
            title: isAdd ? TextWidget(text: "Agregar Equipo") : TextWidget(text: "Editar Equipo"),
            content: Container(
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: textController,
                      maxLength: 10,
                      decoration: InputDecoration(
                        hintText: "Ingrese un nombre"
                      ),
                    ),
                    SizedBox(height: Responsive.of(context).dp(1),),
                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.red, fontSize: 18),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? data) {
                        print(data);
                        setState(() {
                          dropdownValue = data ?? "ACT";
                        });
                      },
                      items: Constants.spinnerItems.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )
                  ],
                ),
              ),
            ),
            actions: [
              isAdd ? MaterialButton(
                onPressed: (){
                  if (textController.text.length > 0){
                    _add(textController.text, dropdownValue);
                  }
                },
                child: TextWidget(text: "Agregar", color: TestColor.fromHex(TestColor.CelesteDark),),
              ): MaterialButton(
                onPressed: (){
                  if (textController.text.length > 0){
                    _edit(textController.text, dropdownValue, id);
                  }
                },
                child: TextWidget(text: "Editar", color: TestColor.fromHex(TestColor.CelesteDark),),
              )
            ],
          ),
        )
      );


    return showCupertinoDialog(
      context: context, 
      builder: (BuildContext context) => StatefulBuilder(builder: (context, StateSetter setState) => 
        CupertinoAlertDialog(
          title: Text("Agregar Equipo"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CupertinoTextField(
                controller: textController,
              ),
              SizedBox(height: Responsive.of(context).dp(1),),
              CupertinoPicker(
                itemExtent: 32.0,
                onSelectedItemChanged: (int index) {
                  setState(() {
                    dropdownValue = Constants.spinnerItems[index];
                  });
                },
                children: new List<Widget>.generate(
                    Constants.spinnerItems.length, (int index) {
                  return new Center(
                    child: new Text(Constants.spinnerItems[index]),
                  );
                })
              ),
            ],
          ),
          actions: [
            isAdd ? CupertinoDialogAction(
              isDefaultAction: true,
              child: Text("Add"),
              onPressed: (){
                if (textController.text.length > 0){
                  _add(textController.text, dropdownValue);
                }
              }
            ): CupertinoDialogAction(
              isDefaultAction: true,
              child: Text("Edit"),
              onPressed: (){
                if (textController.text.length > 0){
                  _edit(textController.text, dropdownValue, id);
                }
              }
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: Text("Dismiss"),
              onPressed: ()=> Navigator.pop(context)
            ),
          ],
        )
      )
    ); 
  }


  void _add(String name, String status) async {
    
    if(Navigator.canPop(context)) Navigator.pop(context);
    showDialog(
      context: context, 
      builder: (_) => LoadingData()
    );

    final result = await EquipoRequestProvider.addEquipos(
      estado: status,
      nombre: name
    );
    Navigator.pop(context);
    setState(() {});
    TestDialog.of(context).infoDialog(title: !result ? "Error" : "Satisfactorio", 
      description: !result ? "No se pudo agregar" : "Se agrego correctamente", func: (){
        if(Navigator.canPop(context)) Navigator.pop(context);
        
      });
    
  }

  void _delete(int id) async {
    showDialog(
      context: context, 
      builder: (_) => LoadingData()
    );

    final result = await EquipoRequestProvider.deleteEquipos(id: id);
    Navigator.pop(context);
    setState(() {});
    TestDialog.of(context).infoDialog(title: !result ? "Error" : "Satisfactorio", 
      description: !result ? "No se pudo eliminar" : "Se elimino correctamente", func: (){
        if(Navigator.canPop(context)) Navigator.pop(context);
        
      });
  }

  void _edit(String name, String status, int id) async {
    if(Navigator.canPop(context)) Navigator.pop(context);
    showDialog(
      context: context, 
      builder: (_) => LoadingData()
    );

    final result = await EquipoRequestProvider.editEquipos(id: id, nombre: name, estado: status);
    Navigator.pop(context);
    setState(() {});
    TestDialog.of(context).infoDialog(title: !result ? "Error" : "Satisfactorio", 
      description: !result ? "No se pudo Modificar" : "Se modifico correctamente", func: (){
        if(Navigator.canPop(context)) Navigator.pop(context);
        
      });
  }
}