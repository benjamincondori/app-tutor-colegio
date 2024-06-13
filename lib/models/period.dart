import 'dart:convert';

List<Period> periodFromMap(String str) =>
    List<Period>.from(json.decode(str).map((x) => Period.fromJson(x)));

String periodToMap(List<Period> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Period {
  late int id;
  late DateTime fechaInicio;
  late DateTime fechaFinal;
  late String tipoPeriodo;
  late String gestion;
  late List<Period> toList = [];

  Period({
    required this.id,
    required this.fechaInicio,
    required this.fechaFinal,
    required this.tipoPeriodo,
    required this.gestion,
  });

  factory Period.fromJson(Map<String, dynamic> json) => Period(
        id: json["id"],
        fechaInicio: DateTime.parse(json["fecha_inicio"]),
        fechaFinal: DateTime.parse(json["fecha_final"]),
        tipoPeriodo: json["tipo_periodo"],
        gestion: json["gestion"],
      );
      
  Period.fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      Period periodsRequest = Period.fromJson(item);
      toList.add(periodsRequest);
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "fecha_inicio":
            "${fechaInicio.year.toString().padLeft(4, '0')}-${fechaInicio.month.toString().padLeft(2, '0')}-${fechaInicio.day.toString().padLeft(2, '0')}",
        "fecha_final":
            "${fechaFinal.year.toString().padLeft(4, '0')}-${fechaFinal.month.toString().padLeft(2, '0')}-${fechaFinal.day.toString().padLeft(2, '0')}",
        "tipo_periodo": tipoPeriodo,
        "gestion": gestion,
      };
}
