import 'dart:convert';

List<Students> studentsFromMap(String str) =>
    List<Students>.from(json.decode(str).map((x) => Students.fromJson(x)));

String studentsToMap(List<Students> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Students {
  late int id;
  late String nombre;
  late String apellidoPaterno;
  late String apellidoMaterno;
  late DateTime? fechaNacimiento;
  late String? direccion;
  late String? foto;
  late Apoderado? apoderado;
  late List<Students> toList = [];

  Students({
    required this.id,
    required this.nombre,
    required this.apellidoPaterno,
    required this.apellidoMaterno,
    required this.fechaNacimiento,
    required this.direccion,
    required this.foto,
    required this.apoderado,
  });

  factory Students.fromJson(Map<String, dynamic> json) => Students(
        id: json["id"],
        nombre: json["nombre"],
        apellidoPaterno: json["apellido_paterno"],
        apellidoMaterno: json["apellido_materno"],
        fechaNacimiento: json["fecha_nacimiento"] == null
            ? null
            : DateTime.parse(json["fecha_nacimiento"]),
        direccion: json["direccion"],
        foto: json["foto"],
        apoderado: json["apoderado"] == null
            ? null
            : Apoderado.fromJson(json["apoderado"]),
      );

  Students.fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      Students studentsRequest = Students.fromJson(item);
      toList.add(studentsRequest);
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "apellido_paterno": apellidoPaterno,
        "apellido_materno": apellidoMaterno,
        "fecha_nacimiento":
            "${fechaNacimiento!.year.toString().padLeft(4, '0')}-${fechaNacimiento!.month.toString().padLeft(2, '0')}-${fechaNacimiento!.day.toString().padLeft(2, '0')}",
        "direccion": direccion,
        "foto": foto,
        "apoderado": apoderado?.toJson(),
      };
}

class Apoderado {
  final int id;
  final String nombre;
  final String apellidos;
  final String carnetIdentidad;
  final String correoElectronico;
  final String telefono;
  final String direccion;

  Apoderado({
    required this.id,
    required this.nombre,
    required this.apellidos,
    required this.carnetIdentidad,
    required this.correoElectronico,
    required this.telefono,
    required this.direccion,
  });

  factory Apoderado.fromJson(Map<String, dynamic> json) => Apoderado(
        id: json["id"],
        nombre: json["nombre"],
        apellidos: json["apellidos"],
        carnetIdentidad: json["carnet_identidad"],
        correoElectronico: json["correo_electronico"],
        telefono: json["telefono"],
        direccion: json["direccion"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "apellidos": apellidos,
        "carnet_identidad": carnetIdentidad,
        "correo_electronico": correoElectronico,
        "telefono": telefono,
        "direccion": direccion,
      };
}
