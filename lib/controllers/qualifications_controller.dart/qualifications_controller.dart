import 'package:flutter/material.dart';
import 'package:school_student_app/models/student.dart';

import '../../models/management.dart';
import '../../models/period.dart';
import '../../models/qualification.dart';
import '../../providers/qualifications/qualifications_provider.dart';
import '../../utils/my_snackbar.dart';

class QualificationsController {
  BuildContext? context;
  late Function refresh;

  Management? selectedManagement;
  Period? selectedPeriod;
  Student? selectedStudent;

  final QualificationsProvider _studentsProvider = QualificationsProvider();

  // User? user;
  // final SharedPref _sharedPref = SharedPref();
  List<Qualification>? qualificationsRequest = [];

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;

    _studentsProvider.init(context);
    // user = User.fromJson(await _sharedPref.read('user'));
    // qualificationsRequest = await getQualifications();
    refresh();
  }

  Future<void> updateQualifications(
      int alumnoId, int gestionId, int periodoId) async {
    await Future.delayed(const Duration(seconds: 1));
    qualificationsRequest =
        await getQualifications(alumnoId, gestionId, periodoId);
    refresh();
  }

  Future<List<Qualification>?> getQualifications(
      int alumnoId, int gestionId, int periodoId) async {
    final List<Qualification>? results = await _studentsProvider
        .getQualifications(alumnoId, gestionId, periodoId);
    refresh();
    return results;
  }

  void getQualificationsByStudent() {
    if (selectedStudent == null) {
      MySnackbar.show(context, 'Debe seleccionar un estudiante');
      return;
    } else if (selectedManagement == null) {
      MySnackbar.show(context, 'Debe seleccionar una gestión');
      return;
    }
    if (selectedPeriod == null) {
      MySnackbar.show(context, 'Debe seleccionar un periodo');
      return;
    }

    updateQualifications(
        selectedStudent!.id, selectedManagement!.id, selectedPeriod!.id);
  }
}
