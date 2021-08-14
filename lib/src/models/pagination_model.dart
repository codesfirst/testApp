import 'package:flutter_testapp/src/models/equipo_model.dart';

class PaginationModel {
  final int count;
  final bool? next;
  final bool? previous;
  final List<EquipoModel> equipoModel;

  PaginationModel({
    required this.count, 
    this.next, 
    this.previous, 
    required this.equipoModel});

  factory PaginationModel.fromJson(Map<String, dynamic> json) => PaginationModel(
    count: json["count"],
    equipoModel: List<EquipoModel>.from(json["results"].map((x) => EquipoModel.fromJson(x))),
    next: json["next"],
    previous: json["next"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "equipoModel": List<dynamic>.from(equipoModel.map((e) => e.toJson())),
    "next": next,
    "previous": previous
  };

}