class EquipoModel {
  final int id;
  final String fecha_creacion;
  final String ultimo_cambio;
  final String nombre;
  final String estado;

  EquipoModel({
    required this.id, 
    required this.fecha_creacion, 
    required this.ultimo_cambio, 
    required this.nombre, 
    required this.estado});

  factory EquipoModel.fromJson(Map<String, dynamic> json) => EquipoModel(
    id: json["id"],
    fecha_creacion: json["fecha_creacion"],
    estado: json["estado"],
    nombre: json["nombre"],
    ultimo_cambio: json["ultimo_cambio"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fecha_creacion": fecha_creacion,
    "estado": estado,
    "nombre": nombre,
    "ultimo_cambio": ultimo_cambio,
  };

}

