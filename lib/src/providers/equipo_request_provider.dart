import 'dart:convert';

import 'package:flutter_testapp/src/models/pagination_model.dart';
import 'package:flutter_testapp/src/networking/api.dart';

enum EquipoStatus {
  ACT,
  INA,
}

class EquipoRequestProvider {
  final String nombre;
  final String estado;

  EquipoRequestProvider({
    required this.nombre, 
    required this.estado});

  
  Map<String, dynamic> toJson () => {
    "nombre": nombre,
    "estado": estado,
  };

  
  static Future<PaginationModel?> getEquipos() async {
    PaginationModel? paginationModel;
    try{
      var api = Api.create();
      final response = await api.getEquipoApi();
      print(response.bodyString);
      if (response.isSuccessful) {
        Map <String, dynamic> resData = json.decode(response.bodyString);
        paginationModel = PaginationModel.fromJson(resData);
      }
    } catch (e) { 
      print(e); //Solo test
    }
    return paginationModel;
  }

  static Future<bool> addEquipos({
    required String nombre,
    required String estado,
  }) async {
    bool isCorrect = false;
    try{
      var api = Api.create();
      final body = EquipoRequestProvider(
        estado: estado,
        nombre: nombre
      );

      final response = await api.postEquipoApi(body.toJson());
      print(response.bodyString);
      if (response.isSuccessful) {
        isCorrect = true;
      }
    } catch (e) { 
      print(e); //Solo test
    }
    return isCorrect ;
  }

  static Future<bool> deleteEquipos({
    required int id,
  }) async {
    bool isCorrect = false;
    try{
      var api = Api.create();
      final response = await api.deleteEquipoApi(id);
      print(response.bodyString);
      if (response.isSuccessful) {
        isCorrect = true;
      }
    } catch (e) { 
      print(e); //Solo test
    }
    return isCorrect ;
  }


  static Future<bool> editEquipos({
    required int id,
    required String nombre,
    required String estado,
  }) async {
    bool isCorrect = false;
    try{
      var api = Api.create();
      final body = EquipoRequestProvider(
        estado: estado,
        nombre: nombre
      );

      final response = await api.putEquipoApi(id, body.toJson());
      print(response.bodyString);
      if (response.isSuccessful) {
        isCorrect = true;
      }
    } catch (e) { 
      print(e); //Solo test
    }
    return isCorrect ;
  }


}