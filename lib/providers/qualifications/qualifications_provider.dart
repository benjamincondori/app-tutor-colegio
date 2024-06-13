import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../api/environment.dart';
import '../../models/qualification.dart';
import '../../utils/shared_pref.dart';

class QualificationsProvider {
  final String _url = Environment.API_URL;
  final String _api = '/api/calificaciones';

  BuildContext? context;

  Future init(BuildContext context) async {
    this.context = context;
  }

  Future<List<Qualification>?> getQualifications(int alumnoId, int gestionId, int periodoId) async {
    try {
      final user = SharedPref().read('user');
      final token = (await user)['token'];

      Uri url = Uri.http(_url, '$_api/$alumnoId/$gestionId/$periodoId');
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      
      final res = await http.get(url, headers: headers);
      final data = json.decode(res.body)['data'];

      // ignore: avoid_print
      print('DATA: $data');

      Qualification results = Qualification.fromJsonList(data);
      return results.toList;
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
      return null;
    }
  }
  
}
