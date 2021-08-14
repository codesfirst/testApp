import 'dart:async';

import 'package:flutter_testapp/src/models/equipo_model.dart';
import 'package:flutter_testapp/src/providers/equipo_request_provider.dart';

class EquiposBloc {
  Stream<List<EquipoModel>> get getEquipos async* {
    List<EquipoModel> equipoList = [];
    final result = await EquipoRequestProvider.getEquipos();
    if(result != null) {
      final equipos = result.equipoModel;
      if (equipos.length > 0){
        for (EquipoModel equipo in equipos) {
          if(equipo.estado.toUpperCase().contains("ACT")) {
            equipoList.add(equipo);
            yield equipoList;
          }
        }
      }
    }
  }

  Stream<int> get equipoContador => _equipoCounter.stream;

  StreamController<int> _equipoCounter = StreamController<int>();

  EquiposBloc(){
    this.getEquipos.listen((equipoList) => this._equipoCounter.add(equipoList.length));
  }

  dispose() {
    _equipoCounter.close();
  }
}