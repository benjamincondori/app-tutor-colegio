import 'dart:convert';

List<Student> estudianteFromMap(String str) =>
    List<Student>.from(json.decode(str).map((x) => Student.fromJson(x)));

String estudianteToMap(List<Student> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Student {
  late int id;
  late String nombre;
  late String apellidoPaterno;
  late String apellidoMaterno;
  late DateTime? fechaNacimiento;
  late String? direccion;
  late String? foto;
  late List<Student> toList = [];

  Student({
    required this.id,
    required this.nombre,
    required this.apellidoPaterno,
    required this.apellidoMaterno,
    required this.fechaNacimiento,
    required this.direccion,
    required this.foto,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json["id"],
        nombre: json["nombre"],
        apellidoPaterno: json["apellido_paterno"],
        apellidoMaterno: json["apellido_materno"],
        fechaNacimiento: json["fecha_nacimiento"] == null
            ? null
            : DateTime.parse(json["fecha_nacimiento"]),
        direccion: json["direccion"],
        foto: json["foto"],
      );

  Student.fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      Student estudiantesRequest = Student.fromJson(item);
      toList.add(estudiantesRequest);
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
      };
}
